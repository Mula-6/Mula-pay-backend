from fastapi import APIRouter
from ..schemas import LoginSchemas, RegistrationSchema
from app.shared.schemas import CustomResponseSchemas

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


@auth_controller.post("/login")
async def login(payload: LoginSchemas):
    pass


@auth_controller.post("/register",response_model=CustomResponseSchemas)
async def register(payload: RegistrationSchema):
    pass