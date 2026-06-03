from redis.asyncio import Redis
from redis.exceptions import ConnectionError as RedisConnectionError
from app.core.config import settings
from app.core.logger import get_logger

logger = get_logger(__name__)

redis: Redis = None

async def redis_init():
    global redis
    
    try:
        if redis is None:
            redis = Redis.from_url(url=settings.REDIS_URL, decode_responses=True)
        
        await redis.ping()
        logger.debug("redis infra connection ready to be used!!!")
        return redis
        
    except RedisConnectionError as e:
        logger.error(f"Failed to connect to Redis at {settings.REDIS_URL}: {e}")
        raise 
    
async def close_redis_conn():
    global redis
    if redis is not None:
        logger.debug("redis infra connection closing!!!")
        await redis.close()
        redis = None  
        
        

async def get_redis():
    return redis 