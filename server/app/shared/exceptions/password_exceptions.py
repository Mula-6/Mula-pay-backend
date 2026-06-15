from .base import AppException


class PasswordResetException(AppException):
    """Custom exception for password reset related errors"""
    def __init__(self, message: str = "Password reset failed", error_code: str = "PASSWORD_RESET_ERROR", status_code: int = 400):
        super().__init__(message=message, error_code=error_code, status_code=status_code)


class PasswordMissingException(PasswordResetException):
    """Exception raised when password is missing"""
    def __init__(self, message: str = "New password is required", error_code: str = "PASSWORD_MISSING", status_code: int = 400):
        super().__init__(message=message, error_code=error_code, status_code=status_code)


class InvalidPasswordResetSessionException(AppException):
    """Exception raised when password reset session is invalid or expired"""
    def __init__(self, message: str = "Invalid or expired password reset session", error_code: str = "INVALID_RESET_SESSION", status_code: int = 401):
        super().__init__(message=message, error_code=error_code, status_code=status_code)


class PasswordResetTokenNotFoundException(AppException):
    """Exception raised when password reset token is not found"""
    def __init__(self, message: str = "Password reset session not found. Please request a new password reset", error_code: str = "RESET_TOKEN_NOT_FOUND", status_code: int = 404):
        super().__init__(message=message, error_code=error_code, status_code=status_code)


class TokenVerificationFailedException(AppException):
    """Exception raised when token verification fails"""
    def __init__(self, message: str = "Token verification failed. Please request a new password reset", error_code: str = "TOKEN_VERIFICATION_FAILED", status_code: int = 401):
        super().__init__(message=message, error_code=error_code, status_code=status_code)
        
        
class PasswordResetSessionAlreadyExistsException(AppException):
    """Exception raised when a password reset session already exists for the user"""
    def __init__(
        self, 
        message: str = "A password reset session has already been created. Please check your email for the reset link.", 
        error_code: str = "PASSWORD_RESET_SESSION_EXISTS", 
        status_code: int = 409  # 409 Conflict
    ):
        super().__init__(message=message, error_code=error_code, status_code=status_code)