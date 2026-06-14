from datetime import datetime, timedelta

from redis.asyncio import Redis
from app.shared.services import RedisService
from app.shared.constants import OtpTokenType
from ..schemas import StageRegistration
import json
from app.shared.constants.keys import get_stage_reg_key, get_token_key, get_session_key, get_rest_password_key
from app.core.logger import get_logger
from app.shared.constants import RegStagedState
from ..schemas import OtpTokenSchemas
from app.shared.handler import CustomDataEncoder
from app.features.user.repository import UserRepo
from app.features.user.schemas import UserBaseSchema
from app.shared.handler import CustomDataEncoder




logger = get_logger(__name__)

class AuthRepo:
    def __init__(self, redis: Redis):
        self.redis = RedisService(redis)
        
    
    
    
    async def create_rest_password_session(self, email: str, token: str):
        await self.redis.set(
            key=get_rest_password_key(email), value=token, exp=timedelta(minutes=3)
        )
        return True
    
    async def get_rest_password_session_token(self, email: str):
        res = await self.redis.get(get_rest_password_key(email))
        return res
    
    async def check_user_exist_in_stage(self, email:str):
        try:
            res = await self.redis.get(get_stage_reg_key(email))
            if res is None:
                return None
            clean_dt = StageRegistration.model_validate(json.loads(res))
            return clean_dt
        except Exception as e:
            logger.error(f"error occured while checking staged user due to -> {e}")
            
            
            
    async def check_is_staged_email_verified(self, email: str):
        get_staged_dt = await self.check_user_exist_in_stage(email)
        if get_staged_dt:
            return RegStagedState.IS_VERIFIED if get_staged_dt.is_email_verified else RegStagedState.NOT_VERIFIED
        return RegStagedState.NON_FOUND
    
    
    async def delete_stage_registration(self, email: str):
        return await self.redis.delete(get_stage_reg_key(email))
    
    

        
        
            
    
            
            
    async def stage_user_registration(self, payload: StageRegistration):
        try:
            key = get_stage_reg_key(payload.reg_dt.email)
            res = await self.redis.set(
                key,
                value=json.dumps(payload.model_dump(mode="json")),
                exp=timedelta(days=7)
            )

            return res

        except Exception as e:
            logger.error(f"error while staging user registration: {e}")
            raise
        
        
    
    async def store_temp_otp(self, data:OtpTokenSchemas, key: str):
        await self.redis.set(key=key, value=json.dumps(data.model_dump(), cls=CustomDataEncoder),  exp= data.expire_at - datetime.utcnow())
        return True
    
    
    async def get_temp_otp(self, email: str, type: OtpTokenType):
        key = get_token_key(email, type)
        res = await self.redis.get(key)
    
            
        if res is not None:
            clean_dt = OtpTokenSchemas.model_validate(json.loads(res))
            return clean_dt
        return None
    
    async def delete_tep_otp(self, email: str, type: OtpTokenType):
        key = get_token_key(email=email, type=type);
        await self.redis.delete(key)
        return True;
    
    async def check_session_exist(self, token: str):
        res = await self.redis.get(get_session_key(token))
        if res is None:
            return None
        clean_dt = UserBaseSchema.model_validate(json.loads(res))
        return clean_dt
    
        
    async def create_user_session(self, email: str, user_repo:UserRepo, token: str, exp: timedelta):        
        res = await user_repo.check_user_exist_in_db(email)
        if res is None:
            return False
        user = UserBaseSchema(email=res.email, firstname=res.firstname, lastname=res.lastname, role=res.role, id=res.id, 
                              is_email_verified=res.is_email_verified, is_enabled=res.is_email_verified, kyc_verification_status=res.kyc_verification_status)
        await self.redis.set(key=get_session_key(token), value=json.dumps(user.model_dump(), cls=CustomDataEncoder), exp=exp)
        return token
        
        
        

        