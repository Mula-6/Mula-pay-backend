from .base import AppException


class UserAlreadyExistsException(AppException):
    def __init__(self):
        super().__init__(
            message="User with this credentials already exists",
            error_code="USER_ALEADY_EXISTS")