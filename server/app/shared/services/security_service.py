from typing import Optional
import jwt
from jwt.exceptions import ExpiredSignatureError, DecodeError, InvalidSignatureError, InvalidTokenError
from app.core.config import settings
from passlib.context import CryptContext
from ...features.auth.schemas import TokenSchemas
from datetime import timedelta, datetime
from fastapi.security import OAuth2PasswordBearer
from datetime import datetime, timedelta
from app.shared.constants import OtpTokenType
from uuid import UUID
import secrets
from ...features.auth.schemas import OtpTokenSchemas
from fastapi import Depends
from app.core.logger import get_logger
from app.shared.exceptions import (
    DecodingTokenException, AccessTokenExpriedException, 
    InvalidTokenException, NoBearerTokenPassedException
)


logger = get_logger(__name__)


oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/api/v1/auth/login")


class SecurityService:
        
    def __init__(self):
        self._sk = settings.SK
        self._algo = settings.ALGO
        self.pwd_contxt = CryptContext(schemes=["bcrypt"], deprecated="auto")
        
    
    def generate_hash_password(self, password: str) -> str:
        return self.pwd_contxt.hash(password)
    
    def verify_hash_password(self, password: str, hash_pass: str) -> bool:
        return self.pwd_contxt.verify(password, hash=hash_pass)
    
    
    def generate_access_token(self, token_data: TokenSchemas) -> str:
        payload = {
            "id": str(token_data.id),
            "email": token_data.useremail,
            "token_type": token_data.token_type.value,
            "role": token_data.role.value,
            "iat": datetime.utcnow(),
            "exp": datetime.utcnow() + (token_data.exp or timedelta(minutes=30))
        }
        return jwt.encode(payload, self._sk, algorithm=self._algo)

    


    def generate_otp(self, length: int = 6, otp_type: Optional[OtpTokenType] =OtpTokenType.VERIFICATION):
        otp = ''.join(str(secrets.randbelow(10)) for _ in range(length))
        expires_at = datetime.utcnow() + timedelta(minutes=5)
        return OtpTokenSchemas(otp=otp, expire_at=expires_at, otp_type=otp_type)
    
    
    def generate_opaque_refresh_token(self):
        return secrets.token_urlsafe(64)
    
    
    async def verify_access_token(self, token: str = Depends(oauth2_scheme)):
        try:
            if token is None:
                raise NoBearerTokenPassedException()
            payload = jwt.decode(token, self._sk, algorithms=[self._algo])
            
            return TokenSchemas(
                id=UUID(payload.get("id")),
                role=payload.get("role"),
                useremail=payload.get("email"),
                token_type=payload.get("token_type")
            )
        
        except ExpiredSignatureError as e:
            logger.error(f"error in token due to -> {e}")
            raise AccessTokenExpriedException()
        except DecodeError as e:
            logger.error(f"error in token due to -> {e}")
            raise DecodingTokenException()
        except InvalidSignatureError as e:
            logger.error(f"error in token due to -> {e}")
            raise InvalidTokenException()
        

security_service = SecurityService()