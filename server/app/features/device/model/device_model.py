from datetime import datetime
from typing import Optional, List
from sqlalchemy import String, Boolean, DateTime, ForeignKey, Float, Integer, func
from sqlalchemy.orm import mapped_column, Mapped, relationship
from sqlalchemy.dialects.postgresql import UUID
import uuid
from app.infra.database import Base

class Device(Base):
    __tablename__ = "device"
    

    id: Mapped[UUID] = mapped_column(
        UUID, 
        primary_key=True, 
        default=uuid.uuid4
    )
    
    device_id: Mapped[str] = mapped_column(
        String(255), 
        nullable=False, 
        index=True,
        
    )
    
    device_name: Mapped[str] = mapped_column(
        String(255), 
        nullable=False,
        
    )
    
    manufacturer: Mapped[str] = mapped_column(
        String(255), 
        nullable=False,
       
    )
    
    platform: Mapped[str] = mapped_column(
        String(50), 
        nullable=False,
        
    )
    
    os_version: Mapped[str] = mapped_column(
        String(50), 
        nullable=False,
        
    )
    
    
    latitude: Mapped[Optional[float]] = mapped_column(
        Float, 
        nullable=True,
        
    )
    
    longitude: Mapped[Optional[float]] = mapped_column(
        Float, 
        nullable=True,
       
    )
    
    fcm_token: Mapped[Optional[str]] = mapped_column(
        String(500), 
        nullable=True,
       
    )
    

    is_active: Mapped[bool] = mapped_column(
        Boolean, 
        default=True,
        nullable=False,
    )
    
    logged_in_at: Mapped[Optional[datetime]] = mapped_column(
        DateTime, 
        nullable=True,
    )
    
    logged_out_at: Mapped[Optional[datetime]] = mapped_column(
        DateTime, 
        nullable=True,
    )
    
    created_at: Mapped[datetime] = mapped_column(
        DateTime, 
        server_default=func.current_timestamp(),
        nullable=False,
    )
    
    updated_at: Mapped[datetime] = mapped_column(
        DateTime, 
        server_default=func.current_timestamp(),
        onupdate=func.current_timestamp(),
        nullable=False,
    )
    
    
    user_id: Mapped[Optional[UUID]] = mapped_column(
        UUID, 
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
    )
    
    
    user: Mapped[Optional["Users"]] = relationship(
        "Users",
        back_populates="devices",
        foreign_keys=[user_id]
    )
    
    def __repr__(self) -> str:
        return f"<Device(id={self.id}, device_name={self.device_name}, platform={self.platform})>"
    