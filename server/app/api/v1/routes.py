from fastapi import APIRouter
from app.features.auth.controllers.auth_controller import auth_controller
from app.features.user.controller.user_controller import user_controller
from app.features.device.controllers.device_controller import device_controller

v1 = APIRouter(
    prefix="/api/v1",
    tags=["v1"],
    responses={
        404:{
            "message":"Not found"
        },
        500:{
            "message":"server error"
        }
    }
)


v1.include_router(auth_controller)
v1.include_router(user_controller)
v1.include_router(device_controller)