from pydantic import BaseModel, EmailStr, Field
from typing import Optional



class LogoutSchemas(BaseModel):
    token: str