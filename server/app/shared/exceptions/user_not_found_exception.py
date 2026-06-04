from .base import AppException

class UserNotFoundException(AppException):
    def __init__(self, email: str):
        super().__init__(
            message=f"User with email {email} does not exist.",
            error_code="USER_NOT_FOUND",
            status_code=404
        )