from pydantic import BaseModel, EmailStr, Field
from typing import Optional



class LoginSchemas(BaseModel):
    email: EmailStr
    password: Optional[str] = Field(description="password", max_length=16, min_length=6)