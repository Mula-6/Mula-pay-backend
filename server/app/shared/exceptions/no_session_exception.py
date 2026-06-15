from .base import AppException

class NoSessionException(AppException):
    def __init__(self, message: str):
        super().__init__(
            message=message,
            error_code="N0_SESSION_ACTIVE",
            status_code=401
        )