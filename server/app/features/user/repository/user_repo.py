from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from app.features.auth.schemas import RegistrationSchema
from app.shared.constants import Roles, KycVerificationState
from ..model import Users
from uuid import uuid4

from app.core.logger import get_logger


logger = get_logger(__name__)

class UserRepo:
    def __init__(self, session: AsyncSession):
        self.session = session
        
        
        
    
    async def check_user_exist_in_db(self, email: str):
        res = await self.session.execute(select(Users).where(Users.email == email))
        output = res.scalar_one_or_none()
        return output
    
    
    async def create_user(self, schemas: RegistrationSchema):
        try:
            self.session.add(
                Users(
                    id=uuid4(),
                    firstname=schemas.firstname,
                    lastname=schemas.lastname,
                    email=schemas.email,
                    is_enabled=True,
                    is_email_verified=True,
                    password=schemas.password,
                    role=Roles.USER.value,
                    kyc_verification_status=KycVerificationState.NOT_STARTED.value
                    
                )
            )
            
            await self.session.commit()
            return True
        except Exception as e:
            logger.error(f"error occured while creating user due to -> {e}")