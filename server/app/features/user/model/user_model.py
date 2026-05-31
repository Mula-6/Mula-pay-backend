from sqlalchemy.orm import mapped_column, Mapped
from sqlalchemy import UUID, String, Boolean, Enum, DateTime, func
import uuid
from app.infra.database import Base
from app.shared.constants import KycVerificationState, Roles




class Users(Base):
    __tablename__ = "users"
    id:Mapped[UUID] = mapped_column(UUID, primary_key=True, default=uuid.uuid4)
    firstname: Mapped[String] = mapped_column(String(200), index=True, unique= False, nullable= False)
    lastname: Mapped[String] = mapped_column(String(200), index=True, unique= False, nullable= False)
    email: Mapped[String] = mapped_column(String(200), index=True, unique= True, nullable= False)
    password: Mapped[String] = mapped_column(String(255))
    is_enabled: Mapped[Boolean] = mapped_column(Boolean, default = False)
    is_email_verified: Mapped[Boolean] = mapped_column(Boolean, default= False, nullable= False)
    kyc_verification_status: Mapped[KycVerificationState] = mapped_column(Enum(KycVerificationState, 
                                                                               name= "kyc_verification_status"), default= KycVerificationState.NOT_STARTED.value)
    role: Mapped[Roles] = mapped_column(Enum(Roles, name="role"))
    created_at: Mapped[DateTime] = mapped_column(DateTime, server_default=func.current_timestamp())
    updated_at: Mapped[DateTime] = mapped_column(DateTime,  server_default=func.current_timestamp())