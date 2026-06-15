from .base import AppException


class NoBearerTokenPassedException(AppException):
    def __init__(self):
        super().__init__(
            message="Un authorizesd",
            error_code="N0_BEARER_TOKEN_PASSED_EXCEPTION",
            status_code=401
        )
        
        



class AccessTokenExpriedException(AppException):
    def __init__(self):
        super().__init__(
            message=f"Access token has expired",
            error_code="ACCESS_TOKEN_EXPIRED",
            status_code=401
        )
        
        

class DecodingTokenException(AppException):
    def __init__(self):
        super().__init__(
            message="Error occured while decoding token",
            error_code="DECODE_ERROR_EXCEPTION",
            status_code=400
        )
        
        

class InvalidTokenException(AppException):
    def __init__(self):
        super().__init__(
            message="Invalid Token provided.",
            error_code="INVALID_OTP",
            status_code=400
        )
        
