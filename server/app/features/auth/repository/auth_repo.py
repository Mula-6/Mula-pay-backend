from datetime import datetime, timedelta

from redis.asyncio import Redis
from app.shared.services import RedisService
from app.shared.constants import OtpTokenType
from ..schemas import StageRegistration
import json
from app.shared.constants.keys import get_stage_reg_key, get_token_key
from app.core.logger import get_logger
from app.shared.constants import RegStagedState
from ..schemas import OtpTokenSchemas
from app.shared.handler import CustomDataEncoder




logger = get_logger(__name__)

class AuthRepo:
    def __init__(self, redis: Redis):
        self.redis = RedisService(redis)
    
    

    
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

        