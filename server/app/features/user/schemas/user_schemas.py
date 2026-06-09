from pydantic import UUID4, BaseModel, ConfigDict, EmailStr, Field
from datetime import datetime
from uuid import UUID
from app.shared.constants import KycVerificationState, Roles
from typing import Optional


class UserBaseSchema(BaseModel):
    id: Optional[UUID] = None
    firstname: str = Field(..., max_length=200, description="User's first name")
    lastname: str = Field(..., max_length=200, description="User's last name")
    email: EmailStr = Field(..., max_length=200, description="User's email address")
    role: Roles = Field(..., description="User's role in the system")
    is_email_verified:bool 
    is_enabled:bool
    kyc_verification_status:KycVerificationState
    model_config= ConfigDict(from_attributes=True)


class CurrentUserSchemas(BaseModel):
    base_info:UserBaseSchema
    model_config = ConfigDict(from_attributes=True)