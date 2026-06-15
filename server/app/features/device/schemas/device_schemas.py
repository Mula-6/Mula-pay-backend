from pydantic import BaseModel, Field, ConfigDict
from typing import Optional
from datetime import datetime

class DeviceInfoSchemas(BaseModel):
    """Pydantic model for device information matching Flutter DeviceInfoModel"""
    
    device_name: str = Field(..., alias="deviceName", description="Device model name")
    device_id: str = Field(..., alias="deviceId", description="Unique device identifier")
    os_version: str = Field(..., alias="osVersion", description="Operating system version")
    manufacturer: str = Field(..., description="Device manufacturer")
    platform: str = Field(..., description="Platform (iOS, Android, Web, etc.)")
    model_config=ConfigDict(populate_by_name=True, from_attributes=True, json_schema_extra = {
            "example": {
                "deviceName": "iPhone 14 Pro",
                "deviceId": "12345-ABCDE-67890",
                "osVersion": "17.2",
                "manufacturer": "Apple",
                "platform": "iOS"
            }
        })


class DeviceRegistrationSchemas(BaseModel):
    """Complete device registration model matching Flutter RegisterDeviceModel"""
    
    device_info: DeviceInfoSchemas = Field(..., alias="deviceInfo")
    fcm_token: Optional[str] = Field(None, alias="fcmToken", description="Firebase Cloud Messaging token")
    model_config=ConfigDict(populate_by_name = True,
                            from_attributes=True,
        json_schema_extra = {
            "example": {
                "deviceInfo": {
                    "deviceName": "iPhone 14 Pro",
                    "deviceId": "12345-ABCDE-67890",
                    "osVersion": "17.2",
                    "manufacturer": "Apple",
                    "platform": "iOS"
                },
                "fcmToken": "fcm_token_string_here",
                "userId": "550e8400-e29b-41d4-a716-446655440000",
            }
        })

class DeviceBaseSchemas(BaseModel):
    """Base device schema with common fields"""
    
    device_id: str = Field(
        ..., 
        max_length=255, 
        description="Unique device identifier",
        examples=["android-12345-67890", "ios-ABCDE-12345"]
    )
    
    device_name: str = Field(
        ..., 
        max_length=255, 
        description="Device model name",
        examples=["iPhone 14 Pro", "Pixel 6", "Samsung Galaxy S23"]
    )
    
    manufacturer: str = Field(
        ..., 
        max_length=255, 
        description="Device manufacturer",
        examples=["Apple", "Google", "Samsung", "OnePlus"]
    )
    
    platform: str = Field(
        ..., 
        max_length=50, 
        description="Platform/OS name",
        examples=["Android", "iOS", "Web", "Windows"]
    )
    
    os_version: str = Field(
        ..., 
        max_length=50, 
        description="Operating system version",
        examples=["17.2", "13", "14", "11"]
    )
    
    fcm_token: Optional[str] = Field(
        None, 
        max_length=500, 
        description="Firebase Cloud Messaging token for push notifications"
    )
    
    is_active: bool = Field(
        True, 
        description="Whether the device is currently active"
    )
    last_seen_at: datetime = Field(..., description="Last time device was seen/active")

    is_discoverable: bool = Field(
        True, 
        description="Whether the device can be discovered by other devices"
    )
    model_config=ConfigDict(populate_by_name=True, from_attributes=True)
    
    

# # Model for updating device FCM token
# class UpdateFCMTokenSchemas(BaseModel):
#     """Model for updating device FCM token"""
    
#     fcm_token: str = Field(..., alias="fcmToken", min_length=1, description="New FCM token")
#     device_id: str = Field(..., alias="deviceId", description="Device identifier")
    
#     class Config:
#         populate_by_name = True
#         json_schema_extra = {
#             "example": {
#                 "fcmToken": "new_fcm_token_string",
#                 "deviceId": "12345-ABCDE-67890"
#             }
#         }


# # Model for device logout
# class DeviceLogoutSchemas(BaseModel):
#     """Model for device logout"""
    
#     device_id: str = Field(..., alias="deviceId", description="Device identifier to logout")
    
#     class Config:
#         populate_by_name = True