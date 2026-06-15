from typing import Annotated
from ..schemas import DeviceRegistrationSchemas

from fastapi import APIRouter, Depends
from app.shared.di import db_injection, redis_injection
from app.shared.services.security_service import security_service
from app.features.auth.schemas import TokenSchemas
from ..service import DeviceService


device_controller = APIRouter(
    prefix="/device",
    tags=["device"],
    responses={
        404:{
            "message":"Not found"
        },
        500:{
            "message":"server error"
        }
    }
)


def get_device_service(
    db: db_injection,
    redis: redis_injection
):
    return DeviceService(session=db, redis=redis)


@device_controller.post("/")
async def register_device(
    schemas:DeviceRegistrationSchemas,
    device_service: Annotated[DeviceService, Depends(get_device_service)],
    verify_user: TokenSchemas  = Depends(security_service.verify_access_token), 
):
    return await device_service.register_device(user_id=verify_user.id, payload= schemas)


@device_controller.get("/")
async def get_current_device(
    device_service: Annotated[DeviceService, Depends(get_device_service)],
    verify_user: TokenSchemas  = Depends(security_service.verify_access_token), 
):
    return await device_service.get_current_device(user_id=verify_user.id,)