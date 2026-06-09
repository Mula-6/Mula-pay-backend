from typing import Annotated

from fastapi import APIRouter, Depends
from app.shared.services import SecurityService
from app.features.auth.schemas import TokenSchemas
from app.shared.services.security_service import security_service
from app.shared.di import db_injection
from ..service import UserService

user_controller = APIRouter(
    prefix="/user",
    tags=["user"],
    responses={
        404:{
            "message":"Not found"
        },
        500:{
            "message":"server error"
        }
    }
)


def get_user_service(
    db: db_injection,
    # redis: redis_injection
):
    return UserService(session=db)



@user_controller.get("/")
async def get_current_user(
user_service : Annotated[UserService, Depends(get_user_service)],
verify_user: TokenSchemas  = Depends(security_service.verify_access_token), 

):
    return await user_service.current_user(verify_user.useremail)