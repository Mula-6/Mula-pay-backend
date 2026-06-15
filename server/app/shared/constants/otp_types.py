from enum import Enum


class OtpTokenType(Enum):
    VERIFICATION = "VERIFICATION"
    FORGET_PASSWORD = "FORGET_PASSWORD"