from .base import AppException

class InvalidCredentialsException(AppException):
    def __init__(self):
        super().__init__(
            message="Invalid email or password.",
            error_code="INVALID_CREDENTIALS",
            status_code=401
        )