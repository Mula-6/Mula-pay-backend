from typing import Optional

import jwt
from app.core.config import settings
from passlib.context import CryptContext
from ..schemas import TokenSchemas
from datetime import timedelta, datetime
from fastapi.security import OAuth2PasswordBearer
from datetime import datetime, timedelta
from app.shared.constants import OtpTokenType
import secrets
from ..schemas import OtpTokenSchemas




class SecurityService:
    
    @staticmethod
    def get_auth_scheme():
        return OAuth2PasswordBearer(tokenUrl="/api/v1/auth/login")
    
    
    def __init__(self):
        self._sk = settings.SK
        self._algo = settings.ALGO
        self.pwd_contxt = CryptContext(schemes=["bcrypt"], deprecated="auto")
        
    
    def generate_hash_password(self, password: str) -> str:
        return self.pwd_contxt.hash(password)
    
    def verify_hash_password(self, password: str, hash_pass: str) -> bool:
        return self.pwd_contxt.verify(password, hash=hash_pass)
    
    
    def generate_token(self, token_data: TokenSchemas) -> str:
        payload = {
            "id": str(token_data.id),
            "email": token_data.useremail,
            "token_type": token_data.token_type,
            "role": token_data.role,
            "iat": datetime.utcnow(),
            "exp": datetime.utcnow() + (token_data.exp or timedelta(minutes=30))
        }
        return jwt.encode(payload, self._sk, algorithm=self._algo)

    


    def generate_otp(self, length: int = 6, otp_type: Optional[OtpTokenType] =OtpTokenType.VERIFICATION):
        otp = ''.join(str(secrets.randbelow(10)) for _ in range(length))
        expires_at = datetime.utcnow() + timedelta(minutes=5)
        return OtpTokenSchemas(otp=otp, expire_at=expires_at, otp_type=otp_type)