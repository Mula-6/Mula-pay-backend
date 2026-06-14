from app.core import settings
from sqlalchemy.ext.asyncio import async_sessionmaker, create_async_engine, AsyncSession
from typing import AsyncIterable
from app.core import get_logger
from sqlalchemy.orm import declarative_base
import contextlib
import ssl




Base = declarative_base()

logger  = get_logger(__name__)


DATABASE_URL = settings.DATABASE_URL
# ssl_context = ssl.create_default_context()

class DbSessionManager:
    def __init__(self, host: str):
        self.__engine = create_async_engine(
            url=host, 
            pool_size=20,
        max_overflow=10,
        pool_pre_ping=True,  
        pool_recycle=3600,   
        echo=False,
    #         connect_args={
    #     "ssl": ssl_context
    # }
            )
        self.__session_maker = async_sessionmaker(
            class_= AsyncSession,
            expire_on_commit=False, 
            autoflush=True, bind=self.__engine)
        
    
    async def start(self):
        try:
            if self.__engine is None or self.__session_maker is None:
                logger.error("No host provided")
                raise RuntimeError()
        
            async with self.__engine.begin() as conn:
                await conn.run_sync(Base.metadata.create_all)
            logger.info("database ready to be used")
        except Exception as e:
            logger.error(f"an error occured while starting db session due to -> {e}")
        
    
    async def end(self):
        if self.__engine is None or self.__session_maker is None:
            return
        
        await self.__engine.dispose()
        self.__engine = None
        self.__session_maker = None
        
        
    
    @contextlib.asynccontextmanager
    async def session(self) -> AsyncIterable[AsyncSession]: 
        if self.__session_maker is None: 
            logger.error("error working with session")
            raise RuntimeError()
        
        async with self.__session_maker() as db_session:
            try:
                yield db_session
            except Exception as e:
                logger.error(f"error occured in session due to -> {e}")
                await db_session.rollback()
                raise
            finally:
                await db_session.close()
        
        
        
db_session_manager = DbSessionManager(DATABASE_URL)



