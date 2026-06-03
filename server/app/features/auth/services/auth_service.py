from sqlalchemy.ext.asyncio import AsyncSession
from ..schemas import RegistrationSchema
from ..repository import AuthRepo
from app.shared.exceptions import UserAlreadyExistsException
from app.shared.services import RedisService, Redis

class AuthService:
    def __init__(self, session: AsyncSession, redis: Redis):
        self.session = session
        self.repo = AuthRepo(session)
        self.redis = RedisService(redis)
    
    async def register(self, schemas: RegistrationSchema):
        check_user = await self.repo.check_user_exist(schemas.email)
        if check_user is not None:
            raise UserAlreadyExistsException()
            
        
        # TODO: STORE IN REDIS TEMPRALY UNTIL EMAIL IS VERIFIED
            
            