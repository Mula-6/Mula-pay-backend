from enum import Enum


class TokenType( Enum):
    ACCESS = "ACCESS"
    REFRESH = "REFRESH"
    RESET_PASSWORD = "RESET_PASSWORD"
    VERIFY_EMAIL = "VERIFY_EMAIL"

