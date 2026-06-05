from pydantic import BaseModel, ConfigDict, EmailStr, Field
from datetime import datetime, timedelta
from typing import Literal
from typing import Optional
from app.shared.constants import OtpTokenType

class OtpTokenSchemas(BaseModel):
    otp: str
    expire_at: Optional[datetime] = Field(
        default_factory=lambda: datetime.utcnow() + timedelta(minutes=10)
    )
    otp_type: Optional[OtpTokenType] = OtpTokenType.VERIFICATION

    model_config = ConfigDict(from_attributes=True)
    
    


class OtpResponseSchemas(BaseModel):
    otp: str
    email: EmailStr
    type: OtpTokenType = OtpTokenType.VERIFICATION
    model_config=ConfigDict(from_attributes=True)
    
    

class OtpRequestSchemas(BaseModel):
    email: EmailStr
    type: OtpTokenType = OtpTokenType.VERIFICATION
    model_config=ConfigDict(from_attributes=True)
    
    
