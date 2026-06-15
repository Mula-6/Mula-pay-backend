from fastapi import FastAPI
from app.core import get_logger
from contextlib import asynccontextmanager
from app.infra.database import db_session_manager
from app.infra.redis import redis_init, close_redis_conn
from app.shared.handler.registery import register_exception_handlers
from .api import v1

logger = get_logger(__name__)


@asynccontextmanager
async def lifespan(app):
    await db_session_manager.start()
    await redis_init()
    yield 
    await db_session_manager.end()
    await close_redis_conn()


app = FastAPI(title="MulaPay-API", lifespan=lifespan)

app.include_router(v1)
register_exception_handlers(app)