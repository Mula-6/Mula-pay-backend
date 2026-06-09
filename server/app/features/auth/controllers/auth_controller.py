from fastapi import APIRouter, BackgroundTasks

from app.features.auth.schemas import RequestAccessToken
from ..schemas import LoginSchemas, RegistrationSchema, OtpRequestSchemas, LogoutSchemas
from ..services import AuthService
from app.shared.schemas import CustomResponseSchemas
from fastapi import Depends
from typing import Annotated
from app.shared.di import db_injection
from ..schemas import OtpResponseSchemas
from app.shared.di import redis_injection
from fastapi.security import OAuth2PasswordRequestForm



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
async def login(
    auth_service: Annotated[AuthService, Depends(get_auth_service)],
    payload: LoginSchemas
):
    return await auth_service.login(payload)



@auth_controller.post("/register")
async def register(
    auth_service: Annotated[AuthService, Depends(get_auth_service)],
    payload: RegistrationSchema,
    task: BackgroundTasks
):
    result = await auth_service.register(payload, task)

    return result


@auth_controller.post("/verify-otp")
async def verifiy_otp(
    auth_service: Annotated[AuthService, Depends(get_auth_service)],
    schemas: OtpResponseSchemas  
    ):
    return await auth_service.verify_otp_code(otp=schemas.otp, email=schemas.email,type=schemas.type)


@auth_controller.post("/request-otp")
async def request_otp(
    schemas: OtpRequestSchemas,
    auth_service: Annotated[AuthService, Depends(get_auth_service)],
    background_task: BackgroundTasks
):
    return await auth_service.request_otp_token(schemas.email, background_task=background_task, type=schemas.type)



@auth_controller.post("/refresh-token")
async def refresh_token(
    schemas: RequestAccessToken,
    auth_service: Annotated[AuthService, Depends(get_auth_service)],
):
    return await auth_service.get_refresh_token(token=schemas.token, token_type=schemas.token_type)


@auth_controller.delete("/logout")
async def logout(
    schemas: LogoutSchemas,
    auth_service: Annotated[AuthService, Depends(get_auth_service)],
):
    return await auth_service.logout(schemas)