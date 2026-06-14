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
        doc="Unique device identifier"
    )
    
    device_name: Mapped[str] = mapped_column(
        String(255), 
        nullable=False,
        doc="Device model name"
    )
    
    manufacturer: Mapped[str] = mapped_column(
        String(255), 
        nullable=False,
        doc="Device manufacturer"
    )
    
    platform: Mapped[str] = mapped_column(
        String(50), 
        nullable=False,
        doc="Platform (iOS, Android, Web, etc.)"
    )
    
    os_version: Mapped[str] = mapped_column(
        String(50), 
        nullable=False,
        doc="Operating system version"
    )
    
    # Location
    latitude: Mapped[Optional[float]] = mapped_column(
        Float, 
        nullable=True,
        doc="Device latitude coordinate"
    )
    
    longitude: Mapped[Optional[float]] = mapped_column(
        Float, 
        nullable=True,
        doc="Device longitude coordinate"
    )
    
    # Notification
    fcm_token: Mapped[Optional[str]] = mapped_column(
        String(500), 
        nullable=True,
        doc="Firebase Cloud Messaging token"
    )
    
    # Status
    is_active: Mapped[bool] = mapped_column(
        Boolean, 
        default=True,
        nullable=False,
        doc="Whether the device is currently active"
    )
    
    # Audit Timestamps
    logged_in_at: Mapped[Optional[datetime]] = mapped_column(
        DateTime, 
        nullable=True,
        doc="Timestamp when user logged in on this device"
    )
    
    logged_out_at: Mapped[Optional[datetime]] = mapped_column(
        DateTime, 
        nullable=True,
        doc="Timestamp when user logged out from this device"
    )
    
    created_at: Mapped[datetime] = mapped_column(
        DateTime, 
        server_default=func.current_timestamp(),
        nullable=False,
        doc="Timestamp when device record was created"
    )
    
    updated_at: Mapped[datetime] = mapped_column(
        DateTime, 
        server_default=func.current_timestamp(),
        onupdate=func.current_timestamp(),
        nullable=False,
        doc="Timestamp when device record was last updated"
    )
    
    # Foreign Key to User
    user_id: Mapped[Optional[UUID]] = mapped_column(
        UUID, 
        ForeignKey("users.id", ondelete="SET NULL"),
        nullable=True,
        index=True,
        doc="Reference to the user who owns this device"
    )
    
    # Relationships
    user: Mapped[Optional["Users"]] = relationship(
        "Users",
        back_populates="devices",
        foreign_keys=[user_id]
    )
    
    def __repr__(self) -> str:
        return f"<Device(id={self.id}, device_name={self.device_name}, platform={self.platform})>"
    