from .base import AppException

class InvalidPayloadException(AppException):
    def __init__(self, message: str):
        super().__init__(
            message=message,
            error_code="INVALID_PAYLOAD",
            status_code=422
        )