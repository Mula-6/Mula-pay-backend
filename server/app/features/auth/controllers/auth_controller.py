from fastapi import APIRouter, BackgroundTasks
from ..schemas import LoginSchemas, RegistrationSchema
from ..services import AuthService
from app.shared.schemas import CustomResponseSchemas
from fastapi import Depends
from typing import Annotated
from app.shared.di import db_injection
from app.shared.di import redis_injection


auth_controller = APIRouter(
    prefix="/auth",
    tags=["auth"],
    responses={
        404:{
            "message":"Not found"
        },
        500:{
            "message":"server error"
        }
    }
)

def get_auth_service(
    db: db_injection,
    redis: redis_injection
):
    return AuthService(session=db, redis=redis)

@auth_controller.post("/login")
async def login(payload: LoginSchemas):
    pass

@auth_controller.post("/register")
async def register(
    auth_service: Annotated[AuthService, Depends(get_auth_service)],
    payload: RegistrationSchema,
    task: BackgroundTasks
):
    result = await auth_service.register(payload, task)

    return result