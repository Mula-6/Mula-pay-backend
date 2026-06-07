from typing import Annotated

from fastapi import APIRouter, Depends
from app.shared.services import SecurityService
from app.features.auth.schemas import TokenSchemas
from app.shared.services.security_service import security_service


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





@user_controller.get("/")
async def get_current_user(user: TokenSchemas  = Depends(security_service.verify_access_token)):
    return user