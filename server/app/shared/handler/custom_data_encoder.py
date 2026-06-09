from enum import Enum
from datetime import datetime
import json

from uuid import UUID

class CustomDataEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, UUID):
            return str(obj)
        
        if isinstance(obj, datetime):
            return obj.isoformat()

        if isinstance(obj, Enum):
            return obj.value

        return super().default(obj)