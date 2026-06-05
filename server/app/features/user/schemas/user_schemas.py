from pydantic import UUID4, BaseModel, ConfigDict, EmailStr, Field
from datetime import datetime
from uuid import UUID
from app.shared.constants import KycVerificationState, Roles
from typing import Optional


class UserBaseSchema(BaseModel):
    id: Optional[str] = None
    firstname: str = Field(..., max_length=200, description="User's first name")
    lastname: str = Field(..., max_length=200, description="User's last name")
    email: EmailStr = Field(..., max_length=200, description="User's email address")
    role: Roles = Field(..., description="User's role in the system")
    model_config= ConfigDict(from_attributes=True)
