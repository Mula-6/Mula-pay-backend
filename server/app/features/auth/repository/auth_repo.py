from sqlalchemy.ext.asyncio import AsyncSession
from app.infra.models import Users
from sqlalchemy import select

class AuthRepo:
    def __init__(self, session: AsyncSession):
        self.session = session
    
    
    async def check_user_exist(self, email: str) -> bool:
        res = await self.session.execute(select(Users).where(Users.email == email))
        output = res.scalar_one_or_none()
        return output
        
        
    