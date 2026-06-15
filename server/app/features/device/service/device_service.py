from datetime import timedelta
import json
from typing import Optional

from pydantic import UUID4
from redis.asyncio import Redis
from sqlalchemy.ext.asyncio import AsyncSession

from app.shared.constants.keys import current_active_device_key
from app.shared.handler import CustomDataEncoder
from app.shared.services import RedisService
from ..schemas import DeviceRegistrationSchemas, DeviceBaseSchemas
from ..repository import DeviceRepo
from app.shared.schemas import CustomResponseSchemas
from app.core import get_logger


logger = get_logger(__name__)

class DeviceService:
    def __init__(self, session: AsyncSession, redis: Redis):
        self.repo = DeviceRepo(session) 
        self.redis = RedisService(redis)
        
    
    
    async def cache_device_helper(self, user_id: UUID4):
        """Cache the user's current device in Redis"""
        try:
            res = await self.repo.get_user_active_device(user_id)
            if res is None:
                logger.warning(f"No active device found for user {user_id}")
                return False
            
            await self.redis.set(
                key=current_active_device_key(user_id), 
                value=json.dumps(res.model_dump(), cls=CustomDataEncoder), 
                exp=timedelta(hours=24)
            )
            logger.debug(f"Cached device for user {user_id}")
            return True
        except Exception as e:
            logger.error(f"Failed to cache device for user {user_id}: {str(e)}")
            return False
    
    
    async def get_current_device(self, user_id: UUID4) -> Optional[DeviceBaseSchemas]:
        cache_key = current_active_device_key(user_id)
        
        try:
            # Try to get from Redis first
            cached_device = await self.redis.get(cache_key)
            
            if cached_device:
                logger.debug(f"Device cache hit for user {user_id}")
                if isinstance(cached_device, str):
                    cached_device = json.loads(cached_device)
                return CustomResponseSchemas.success_response(data=DeviceBaseSchemas(**cached_device))
            
            # Cache miss - get from database
            logger.debug(f"Device cache miss for user {user_id}, fetching from database")
            device = await self.repo.get_user_active_device(user_id)
            
            if device:
                # Cache it for future requests
                await self.redis.set(
                    key=cache_key,
                    value=json.dumps(device.model_dump(), cls=CustomDataEncoder),
                    exp=timedelta(hours=24)
                )
                return CustomResponseSchemas.success_response(data=DeviceBaseSchemas.model_validate(device))
            
            logger.warning(f"No active device found for user {user_id}")
            return CustomResponseSchemas.error_response(data=None, message="No active device found")
            
        except Exception as e:
            logger.error(f"Error getting current device for user {user_id}: {str(e)}")
            try:
                device = await self.repo.get_user_active_device(user_id)
                
                return CustomResponseSchemas.success_response(data=DeviceBaseSchemas.model_validate(device) if device else None)
            except Exception as db_error:
                logger.error(f"Fallback database query failed: {str(db_error)}")
                return  CustomResponseSchemas.error_response(data=None, message="error occured while getting user device")
            
            

    async def register_device(self, user_id: UUID4, payload: DeviceRegistrationSchemas):
        try:
            # Check if device already exists
            existing_device = await self.repo.check_device_exist_in_db(user_id)

            if existing_device:
                # Update existing device
                logger.info(f"Device {payload.device_info.device_id} already exists for user {user_id}. Updating...")

                updated_device = await self.repo.update_device(
                    device_id=payload.device_info.device_id,
                    user_id=user_id,
                    payload=payload
                )

                if not updated_device:
                    logger.error(f"Failed to update device {payload.device_info.device_id}")
                    return CustomResponseSchemas.error_response(
                        data=False,
                        message="Failed to update device. Please try again.",
                    )

                # Store in Redis
                await self.redis.set(
                    exp=timedelta(hours=24),
                    key=current_active_device_key(user_id), 
                    value=json.dumps(updated_device.model_dump(), cls=CustomDataEncoder)
                )

                return CustomResponseSchemas.success_response(
                    data=True,
                    message="Device updated successfully"
                )

            else:
                # Create new device
                logger.info(f"Registering new device {payload.device_info.device_id} for user {user_id}")

                new_device = await self.repo.create_device(user_id, payload)

                if not new_device:
                    logger.error(f"Failed to create device {payload.device_info.device_id}")
                    return CustomResponseSchemas.error_response(
                        data=False,
                        message="Failed to register device. Please try again.",
                    )

                # Store in Redis
                await self.redis.set(
                    exp=timedelta(hours=24),
                    key=current_active_device_key(user_id), 
                    value=json.dumps(new_device.model_dump(), cls=CustomDataEncoder)
                )

                return CustomResponseSchemas.success_response(
                    data=True,
                    message="Device registered successfully"
                )

        except Exception as e:
            logger.error(f"Error in register_device for user {user_id}: {str(e)}")
            return CustomResponseSchemas.error_response(
                message=f"An error occurred while registering device: {str(e)}",
            )


