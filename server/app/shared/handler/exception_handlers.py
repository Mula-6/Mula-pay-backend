from fastapi import Request
from fastapi.responses import JSONResponse

from app.shared.schemas import CustomResponseSchemas
from app.shared.exceptions.base import AppException



async def app_exception_handler(request: Request, exc: AppException):
    return JSONResponse(
        status_code=400,
        content=CustomResponseSchemas.error_response(
            message=exc.message,
            error_code=exc.error_code,
            status_code= exc.status_code
        ).model_dump(mode="json")
        
    )