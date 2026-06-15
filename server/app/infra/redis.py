import asyncio
from typing import Optional

from redis.asyncio import Redis
from redis.exceptions import ConnectionError as RedisConnectionError
from app.core.config import settings
from app.core.logger import get_logger

logger = get_logger(__name__)

redis: Redis = None
async def redis_init(max_retries: int = 3, retry_delay: float = 1.0):
    global redis
    
    for attempt in range(max_retries):
        try:
            if redis is None:
                logger.info(f"Connecting to Redis  (attempt {attempt + 1}/{max_retries})")
                
                redis = Redis.from_url(
                    url=settings.REDIS_URL,
                    decode_responses=True,
                    socket_connect_timeout=5,
                    socket_timeout=5,
                    socket_keepalive=True,
                    retry_on_timeout=True, 
                    max_connections=10,  
                    health_check_interval=30  
                )
            
           
            await asyncio.wait_for(redis.ping(), timeout=3.0)
            logger.info("Redis connection established successfully")
            return redis
            
        except (RedisConnectionError, TimeoutError, asyncio.TimeoutError) as e:
            logger.warning(f"Redis connection attempt {attempt + 1} failed: {e}")
            
            # Close failed connection
            if redis:
                await redis.close()
                redis = None
            
            # Retry if not last attempt
            if attempt < max_retries - 1:
                await asyncio.sleep(retry_delay)
            else:
                logger.error(f"Failed to connect to Redis after {max_retries} attempts")
                # Don't raise error - allow app to start without Redis
                # Return None and let app handle gracefully
                return None
    
    return None

async def close_redis_conn():
    """Gracefully close Redis connection"""
    global redis
    if redis is not None:
        try:
            logger.debug("Closing Redis connection...")
            await asyncio.wait_for(redis.close(), timeout=2.0)
            logger.debug("Redis connection closed successfully")
        except Exception as e:
            logger.error(f"Error closing Redis connection: {e}")
        finally:
            redis = None
            

async def get_redis() -> Optional[Redis]:
    """Get Redis client with health check"""
    global redis
    
    if redis is None:
        logger.warning("Redis client not initialized")
        return None
    
    try:
        # Check if connection is still alive
        await asyncio.wait_for(redis.ping(), timeout=1.0)
        return redis
    except Exception as e:
        logger.error(f"Redis health check failed: {e}")
        # Attempt to reconnect
        await redis_init()
        return redis