from fastapi import APIRouter


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
async def login():
    pass