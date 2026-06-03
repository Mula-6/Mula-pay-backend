from pydantic import BaseModel, ConfigDict, Field
from datetime import datetime, timedelta
from typing import Optional
from app.shared.constants import OtpTokenType

class OtpTokenSchemas(BaseModel):
    otp: str
    expire_at: Optional[datetime] = Field(
        default_factory=lambda: datetime.utcnow() + timedelta(minutes=10)
    )
    otp_type: Optional[OtpTokenType] = OtpTokenType.VERIFICATION

    model_config = ConfigDict(from_attributes=True)