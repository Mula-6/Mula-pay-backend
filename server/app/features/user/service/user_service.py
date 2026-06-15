
from ..repository import UserRepo
from sqlalchemy.ext.asyncio import AsyncSession
from ..schemas import CurrentUserSchemas
from app.shared.exceptions import UserNotFoundException
from app.shared.schemas import CustomResponseSchemas
from ..schemas import UserBaseSchema

class UserService:
    def __init__(self, session: AsyncSession):
        self.user_repo = UserRepo(session)
        
        
    async def current_user(self, email: str):
        res = await self.user_repo.check_user_exist_in_db(email)
        if res is None:
            raise UserNotFoundException(email)
        return CustomResponseSchemas.success_response(data=CurrentUserSchemas(
            base_info=UserBaseSchema.model_validate(res)
        ))