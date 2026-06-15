from .base import AppException

class OtpAlreadySentException(AppException):
    def __init__(self, email: str):
        super().__init__(
            message=f"OTP already sent to {email}. Please wait before requesting another.",
            error_code="OTP_ALREADY_SENT",
            status_code=429
        )
        
        

class OtpNotFoundException(AppException):
    def __init__(self):
        super().__init__(
            message="OTP has expired or does not exist.",
            error_code="OTP_NOT_FOUND",
            status_code=404
        )
        
        

class InvalidOtpException(AppException):
    def __init__(self):
        super().__init__(
            message="Invalid OTP provided.",
            error_code="INVALID_OTP",
            status_code=400
        )
        

class OtpTypeMismatchException(AppException):
    def __init__(self):
        super().__init__(
            message="OTP type mismatch.",
            error_code="OTP_TYPE_MISMATCH",
            status_code=400
        )