from pydantic import BaseModel, EmailStr, Field, field_validator, ValidationError, ConfigDict
from typing import Optional, Pattern
import re
from datetime import datetime

class RegistrationSchema(BaseModel):
    firstname: str = Field(..., min_length=2, max_length=50, description="First name")
    lastname: str = Field(..., min_length=2, max_length=50, description="Last name")
    email: EmailStr = Field(..., description="Valid email address")
    password: str = Field(..., min_length=8, max_length=200, description="Password")
    model_config= ConfigDict(from_attributes=True)
    
    @field_validator('firstname')
    def validate_firstname(cls, v):
        """Validate first name"""
        if not v.strip():
            raise ValueError('First name cannot be empty or only spaces')
        if not v.isalpha():
            raise ValueError('First name must contain only letters')
        if len(v) < 2:
            raise ValueError('First name must be at least 2 characters')
        if len(v) > 50:
            raise ValueError('First name must be less than 50 characters')
        return v.strip().title()  # Capitalize first letter
    
    @field_validator('lastname')
    def validate_lastname(cls, v):
        """Validate last name"""
        if not v.strip():
            raise ValueError('Last name cannot be empty or only spaces')
        if not v.isalpha():
            raise ValueError('Last name must contain only letters')
        if len(v) < 2:
            raise ValueError('Last name must be at least 2 characters')
        if len(v) > 50:
            raise ValueError('Last name must be less than 50 characters')
        return v.strip().title()
    
    @field_validator('password')
    def validate_password_strength(cls, v):
        """Validate password strength"""
        if len(v) < 8:
            raise ValueError('Password must be at least 8 characters long')
        
        if len(v) > 128:
            raise ValueError('Password must be less than 128 characters')
        
        # Check for at least one uppercase letter
        if not re.search(r'[A-Z]', v):
            raise ValueError('Password must contain at least one uppercase letter')
        
        # Check for at least one lowercase letter
        if not re.search(r'[a-z]', v):
            raise ValueError('Password must contain at least one lowercase letter')
        
        # Check for at least one digit
        if not re.search(r'\d', v):
            raise ValueError('Password must contain at least one number')
        
        # Check for at least one special character
        if not re.search(r'[!@#$%^&*(),.?":{}|<>]', v):
            raise ValueError('Password must contain at least one special character')
        
        # Check for common patterns
        common_passwords = ['password123', 'admin123', 'qwerty123', '12345678']
        if v.lower() in common_passwords:
            raise ValueError('Password is too common, please choose a stronger password')
        
        return v
    


    
 
    @field_validator('email')
    def email_not_disposable(cls, v):
        """Optional: Block disposable email domains"""
        # List of common disposable email domains
        disposable_domains = [
            'tempmail.com', 'throwaway.com', 'mailinator.com',
            'guerrillamail.com', '10minutemail.com'
        ]
        
        domain = v.split('@')[1].lower()
        if domain in disposable_domains:
            raise ValueError('Disposable email addresses are not allowed')
        
        return v




class StageRegistration(BaseModel):
    reg_dt: RegistrationSchema
    is_email_verified:Optional[bool] = False
    model_config= ConfigDict(from_attributes=True)