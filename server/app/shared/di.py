from fastapi import Depends
from sqlalchemy.ext.asyncio import AsyncSession
from redis.asyncio import Redis
from app.infra.database import db_session_manager
from typing import Annotated
from app.infra.redis import redis_init, get_redis


async def get_db():
    async with db_session_manager.session() as session:
        yield session



        
        
        
db_injection = Annotated[AsyncSession, Depends(get_db)]
redis_injection = Annotated[Redis, Depends(get_redis)]

