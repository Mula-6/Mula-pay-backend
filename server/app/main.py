from fastapi import FastAPI
from app.core import get_logger
from contextlib import asynccontextmanager
from app.infra.database import db_session_manager

logger = get_logger(__name__)


@asynccontextmanager
async def lifespan(app):
    await db_session_manager.start()
    yield 
    await db_session_manager.end()


app = FastAPI(title="MulaPay-API", lifespan=lifespan)

