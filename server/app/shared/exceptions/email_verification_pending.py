from .base import AppException



class EmailVerificationPendingException(AppException):
    def __init__(self):
        super().__init__(
            message="Email verification is still pending",
            error_code="EMAIL_NOT_VERIFIED"
        )