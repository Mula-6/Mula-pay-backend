from fastapi import FastAPI
from .exception_handlers import app_exception_handler
from app.shared.exceptions.base import AppException


def register_exception_handlers(app: FastAPI):

    app.add_exception_handler(
        AppException,
        app_exception_handler
    )