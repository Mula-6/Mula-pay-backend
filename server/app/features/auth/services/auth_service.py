from datetime import timedelta
import json

from sqlalchemy.ext.asyncio import AsyncSession

from app.shared.constants import RegStagedState, OtpTokenType
from app.features.auth.schemas import TokenSchemas
from app.shared.constants import TokenType
from app.features.user.schemas import UserBaseSchema
from app.shared.exceptions import NoSessionException
from app.features.auth.schemas import LogoutSchemas
from ..schemas import LoginSchemas
from ..schemas import RegistrationSchema, StageRegistration
from ..repository import AuthRepo
from app.shared.exceptions import (UserAlreadyExistsException, EmailVerificationPendingException, OtpAlreadySentException, 
                                   OtpNotFoundException, InvalidOtpException, UserNotFoundException, 
                                   InvalidCredentialsException,InvalidPayloadException )
from app.shared.services import RedisService, Redis
from app.features.user.repository import UserRepo
from ....shared.services import SecurityService
from app.shared.schemas import CustomResponseSchemas
from app.shared.services import EmailService
from fastapi import BackgroundTasks
from app.shared.constants.keys import get_token_key, get_session_key



class AuthService:
    def __init__(self, session: AsyncSession, redis: Redis):
        self.session = session
        self.repo = AuthRepo(redis)
        self.redis = RedisService(redis)
        self.user_repo = UserRepo(session)
        self.security = SecurityService()
        self.email_service = EmailService()
        
            
    async def login(self, payload: LoginSchemas):
        res = await self.user_repo.check_user_exist_in_db(payload.email)
    
        if res is None:
            raise UserNotFoundException(payload.email)
    
        if not self.security.verify_hash_password(payload.password, res.password):
            raise InvalidCredentialsException()
        
     
        opaque_token = self.security.generate_opaque_refresh_token()
        access_token = self.security.generate_access_token(token_data=TokenSchemas(
            exp=timedelta(minutes=40), 
            id=res.id,
            useremail=res.email,
            role=res.role,
            token_type=TokenType.ACCESS,
        ))
        
        await self.repo.create_user_session(email=res.email, user_repo=self.user_repo, token= opaque_token,exp=timedelta(days=7))
        return CustomResponseSchemas.success_response(
            data={
                "access_token": access_token,
                "opaque_token": opaque_token,
                "token_type": "Bearer token"
                },
            message="Login was successful"
        )
    
    
        
        
    async def user_email_verified(self, email: str):
        user = await self.repo.check_user_exist_in_stage(email)
        if user is not None:
            await self.repo.delete_stage_registration(user.reg_dt.email)
            await self.user_repo.create_user(user.reg_dt)
            return CustomResponseSchemas.success_response(data=None, message="Your email have been verified")
            
    
    async def register(self, schemas: RegistrationSchema, background_task: BackgroundTasks):
        check_user = await self.user_repo.check_user_exist_in_db(schemas.email)
        if check_user is not None:
            raise UserAlreadyExistsException()
        schemas.password = self.security.generate_hash_password(schemas.password)  
        check_user_staged = await self.repo.check_user_exist_in_stage(schemas.email)
        if check_user_staged is not None:
            match await self.repo.check_is_staged_email_verified(schemas.email):
                case RegStagedState.IS_VERIFIED:
                    # delete from redis
                    self.user_email_verified(schemas.email)

                    
                
                case RegStagedState.NOT_VERIFIED:
                    raise EmailVerificationPendingException()
           
        if check_user_staged is None:
            await self.request_otp_token(schemas.email, background_task, OtpTokenType.VERIFICATION)
            # await self.email_service.send_email_otp(email=schemas.email,otp=self.security.generate_otp())  
            # await self.repo.stage_user_registration(StageRegistration(reg_dt=schemas, is_email_verified=False))
            background_task.add_task(self.repo.stage_user_registration, StageRegistration(reg_dt=schemas, is_email_verified=False))
            
        return CustomResponseSchemas.success_response(data=None, message="Verify your email before proceeding...")
    
    

    async def request_otp_token(
        self,
        email: str,
        background_task: BackgroundTasks,
        type: OtpTokenType
    ):
        res = await self.repo.get_temp_otp(email, type)

        if res:
            raise OtpAlreadySentException(email)

        otp_key = get_token_key(email, type)
        otp = self.security.generate_otp()

        background_task.add_task(
            self.email_service.send_email_otp,
            email=email,
            otp=otp.otp
        )

        background_task.add_task(
            self.repo.store_temp_otp,
            data=otp,
            key=otp_key
        )

        return CustomResponseSchemas.success_response(
            data=None,
            message=f"Otp was sent to {email}"
        )
    
    async def verify_otp_code(self, otp: str, email: str, type: OtpTokenType):
        res = await self.repo.get_temp_otp(email, type)

        if res is None:
            raise OtpNotFoundException()

        if res.otp != otp:
            raise InvalidOtpException()

        match type:
            case OtpTokenType.VERIFICATION:
               return await self.user_email_verified(email)

            # case OtpTokenType.TRANSFER:
            #     # handle transfer logic
            #     pass

            # case OtpTokenType.PASSWORD_RESET:
            #     # handle reset logic
            #     pass
            
    
    async def get_refresh_token(self, token: str, token_type: TokenType):
        user = await self.repo.check_session_exist(token)
        if user is None:
            raise NoSessionException("No User session active, Login again...")
      
        access_token = self.security.generate_access_token(token_data=TokenSchemas(
            exp=timedelta(minutes=40), 
            id=user.id,
            useremail=user.email,
            role=user.role,
            token_type=token_type,
        ))
        return CustomResponseSchemas.success_response(
            data={
                "access_token": access_token
            }
        )
            
    async def logout(self, schemas: LogoutSchemas):
        res = await self.redis.delete(get_session_key(schemas.token))
        return CustomResponseSchemas.success_response(data=res, message="You have logged out successfully")










