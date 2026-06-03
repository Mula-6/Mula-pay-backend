from redis.asyncio import Redis
from app.core.logger import get_logger
from typing import Optional, Any
from datetime import timedelta

logger = get_logger(__name__)


class RedisService:
    def __init__(self, re: Redis):
        self.re = re

    async def check_redis_init(self):
        if self.re is None:
            logger.error("No redis injection passed")
            raise RuntimeError("Redis client not initialized")

    async def get(
        self,
        key: str,
        exp: Optional[timedelta] = None
    ):
        try:
            await self.check_redis_init()

            if exp is None:
                return await self.re.get(key)

            return await self.re.getex(
                key,
                ex=int(exp.total_seconds())
            )

        except Exception as e:
            logger.error(f"error getting from redis due to -> {e}")
            raise

    async def set(
        self,
        key: str,
        value: Any,
        exp: Optional[timedelta] = None
    ):
        try:
            await self.check_redis_init()

            if exp is None:
                await self.re.set(key, value)

            else:
                await self.re.setex(
                    key,
                    int(exp.total_seconds()),
                    value
                )

            return True

        except Exception as e:
            logger.error(f"error setting redis due to -> {e}")
            raise
        
    
    async def delete(self, key: str):
        try:
            await self.check_redis_init()
            await self.re.delete(key)
            return True

        except Exception as e:
            logger.error(f"error deleting from  redis due to -> {e}")
            raise