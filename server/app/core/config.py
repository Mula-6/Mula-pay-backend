from pydantic_settings import BaseSettings
from dotenv import load_dotenv


load_dotenv()

class Settings(BaseSettings):
    DATABASE_URL: str
    SK: str
    ALGO: str
    
    REDIS_URL: str
    
    
    # Email sending keys
    MAIL_JET_API:str
    MAIL_JET_SK:str
    APP_EMAIL_SENDER:str
    
    
    


settings = Settings()