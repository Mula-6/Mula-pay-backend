from pydantic import BaseModel, UUID4, EmailStr
from typing import Optional
from datetime import datetime, timedelta
from app.shared.constants import Roles, TokenType


class TokenSchemas(BaseModel):
    id: UUID4
    useremail: EmailStr
    exp: Optional[timedelta] = None
    role: Optional[Roles] = Roles.USER
    token_type: Optional[TokenType] = TokenType.ACCESS
    
    