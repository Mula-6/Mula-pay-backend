from sqlalchemy import desc, select, update, delete
from sqlalchemy.ext.asyncio import AsyncSession
from datetime import datetime
from typing import Optional, List
from pydantic import UUID4

from ..schemas import DeviceRegistrationSchemas, DeviceBaseSchemas
from ..model import Device


class DeviceRepo:
    def __init__(self, session: AsyncSession):
        self.session = session
        
        
    
    async def get_user_active_device(self, user_id: UUID4) -> Optional[DeviceBaseSchemas]:
        res = await self.session.execute(
            select(Device)
            .where(
                Device.user_id == user_id,
                Device.is_active == True
            )
            .order_by(desc(Device.last_seen_at))
            .limit(1)
        )
        output =  res.scalar_one_or_none()
        if output is None:
            return None
        clean_dt = DeviceBaseSchemas.model_validate(output)
        return clean_dt
 
        
    async def check_device_exist_in_db(self, user_id: UUID4) -> Optional[DeviceBaseSchemas]:
        """Check if device exists by user_id"""
        res = await self.session.execute(
            select(Device).where(Device.user_id == user_id)
        )
        output =  res.scalar_one_or_none()
        if output is None:
            return None
        clean_dt = DeviceBaseSchemas.model_validate(output)
        return clean_dt
    
    async def check_device_exist_by_id(self, device_uuid: UUID4) -> Optional[DeviceBaseSchemas]:
        """Check if device exists by UUID primary key"""
        res = await self.session.execute(
            select(Device).where(Device.id == device_uuid)
        )
        output = await res.scalar_one_or_none()
        if output is None:
            return None
        clean_dt = DeviceBaseSchemas.model_validate(output)
        return clean_dt
    
    async def create_device(self, user_id: UUID4, payload: DeviceRegistrationSchemas) -> DeviceBaseSchemas:
        """Create a new device for a user"""

        # Create new device
        new_device = Device(
            device_id=payload.device_info.device_id,
            device_name=payload.device_info.device_name,
            manufacturer=payload.device_info.manufacturer,
            platform=payload.device_info.platform,
            os_version=payload.device_info.os_version,
            fcm_token=payload.fcm_token,
            is_active=True,
            is_discoverable=False,
            last_seen_at=datetime.utcnow(),
            logged_in_at=datetime.utcnow(),
            user_id=user_id
        )
        
        self.session.add(new_device)
        await self.session.commit()
        await self.session.refresh(new_device)
        
        clean_dt = DeviceBaseSchemas.model_validate(new_device)
        return clean_dt
    
    async def update_device(
        self, 
        device_id: str, 
        user_id: UUID4, 
        payload: DeviceRegistrationSchemas
    ) -> Optional[DeviceBaseSchemas]:
        """Update an existing device"""
        # Parse location if provided
        latitude = None
        longitude = None
        if payload.loc:
            try:
                coords = payload.loc.split(',')
                if len(coords) == 2:
                    latitude = float(coords[0])
                    longitude = float(coords[1])
            except (ValueError, AttributeError):
                pass
        
        # Update device
        stmt = (
            update(Device)
            .where(Device.device_id == device_id)
            .values(
                device_name=payload.device_info.device_name,
                manufacturer=payload.device_info.manufacturer,
                platform=payload.device_info.platform,
                os_version=payload.device_info.os_version,
                latitude=latitude,
                longitude=longitude,
                fcm_token=payload.fcm_token,
                user_id=user_id,
                is_active=True,
                logged_in_at=datetime.utcnow(),
                updated_at=datetime.utcnow()
            )
            .returning(Device)
        )
        
        res = await self.session.execute(stmt)
        await self.session.commit()
        output =  res.scalar_one_or_none()
        
        if output is None:
            return None
        clean_dt = DeviceBaseSchemas.model_validate(output)
        return clean_dt
    
    # async def get_user_devices(self, user_id: UUID4) -> List[Device]:
    #     """Get all devices belonging to a user"""
    #     res = await self.session.execute(
    #         select(Device).where(Device.user_id == user_id)
    #     )
    #     devices = res.scalars().all()
    #     return list(devices)
    
    # async def get_active_user_devices(self, user_id: UUID4) -> List[Device]:
    #     """Get only active devices for a user"""
    #     res = await self.session.execute(
    #         select(Device).where(
    #             Device.user_id == user_id,
    #             Device.is_active == True
    #         )
    #     )
    #     devices = res.scalars().all()
    #     return list(devices)
    
    # async def get_device_by_id(self, device_id: str) -> Optional[Device]:
    #     """Get device by device_id"""
    #     return await self.check_device_exist_in_db(device_id)
    
    # async def deactivate_device(self, device_id: str) -> bool:
    #     """Deactivate a device (soft delete)"""
    #     stmt = (
    #         update(Device)
    #         .where(Device.device_id == device_id)
    #         .values(
    #             is_active=False,
    #             logged_out_at=datetime.utcnow(),
    #             updated_at=datetime.utcnow()
    #         )
    #     )
        
    #     res = await self.session.execute(stmt)
    #     await self.session.commit()
    #     return res.rowcount > 0
    
    # async def activate_device(self, device_id: str) -> bool:
    #     """Activate a device"""
    #     stmt = (
    #         update(Device)
    #         .where(Device.device_id == device_id)
    #         .values(
    #             is_active=True,
    #             logged_in_at=datetime.utcnow(),
    #             updated_at=datetime.utcnow()
    #         )
    #     )
        
    #     res = await self.session.execute(stmt)
    #     await self.session.commit()
    #     return res.rowcount > 0
    
    # async def update_device_fcm_token(self, device_id: str, fcm_token: str) -> Optional[Device]:
    #     """Update FCM token for a device"""
    #     stmt = (
    #         update(Device)
    #         .where(Device.device_id == device_id)
    #         .values(
    #             fcm_token=fcm_token,
    #             updated_at=datetime.utcnow()
    #         )
    #         .returning(Device)
    #     )
        
    #     res = await self.session.execute(stmt)
    #     await self.session.commit()
    #     return res.scalar_one_or_none()
    
    # async def update_device_location(
    #     self, 
    #     device_id: str, 
    #     latitude: float, 
    #     longitude: float
    # ) -> Optional[Device]:
    #     """Update device location"""
    #     stmt = (
    #         update(Device)
    #         .where(Device.device_id == device_id)
    #         .values(
    #             latitude=latitude,
    #             longitude=longitude,
    #             updated_at=datetime.utcnow()
    #         )
    #         .returning(Device)
    #     )
        
    #     res = await self.session.execute(stmt)
    #     await self.session.commit()
    #     return res.scalar_one_or_none()
    
    # async def logout_device(self, device_id: str) -> bool:
    #     """Logout device (deactivate and set logout time)"""
    #     stmt = (
    #         update(Device)
    #         .where(Device.device_id == device_id)
    #         .values(
    #             is_active=False,
    #             logged_out_at=datetime.utcnow(),
    #             updated_at=datetime.utcnow()
    #         )
    #     )
        
    #     res = await self.session.execute(stmt)
    #     await self.session.commit()
    #     return res.rowcount > 0
    
    # async def delete_device(self, device_id: str) -> bool:
    #     """Permanently delete a device"""
    #     stmt = delete(Device).where(Device.device_id == device_id)
    #     res = await self.session.execute(stmt)
    #     await self.session.commit()
    #     return res.rowcount > 0
    
    # async def delete_all_user_devices(self, user_id: UUID4) -> int:
    #     """Delete all devices for a user"""
    #     stmt = delete(Device).where(Device.user_id == user_id)
    #     res = await self.session.execute(stmt)
    #     await self.session.commit()
    #     return res.rowcount
    
    # async def get_device_count_by_user(self, user_id: UUID4) -> int:
    #     """Get count of devices for a user"""
    #     res = await self.session.execute(
    #         select(Device).where(Device.user_id == user_id)
    #     )
    #     devices = res.scalars().all()
    #     return len(list(devices))
    
    # async def get_device_by_fcm_token(self, fcm_token: str) -> Optional[Device]:
    #     """Get device by FCM token"""
    #     res = await self.session.execute(
    #         select(Device).where(Device.fcm_token == fcm_token)
    #     )
    #     output = await res.scalar_one_or_none()
    #     return output