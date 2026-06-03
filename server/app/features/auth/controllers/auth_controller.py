from fastapi import APIRouter
from ..schemas import LoginSchemas, RegistrationSchema
from ..services import AuthService
from app.shared.schemas import CustomResponseSchemas
from fastapi import Depends
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
    db=Depends(db_injection),
    redis=Depends(redis_injection)
):
    return AuthService(db=db, redis=redis)


@auth_controller.post("/login")
async def login(payload: LoginSchemas):
    pass


@auth_controller.post("/register",response_model=CustomResponseSchemas)
async def register(payload: RegistrationSchema, auth_service: AuthService = Depends(get_auth_service)):
    return await auth_service.register(payload)
    