from ..constants import OtpTokenType

def get_stage_reg_key(email:str):
    return f"staged_registration:{email}"



def get_token_key(email: str, type: OtpTokenType):
    return f"{type.value}-otp:{email}"