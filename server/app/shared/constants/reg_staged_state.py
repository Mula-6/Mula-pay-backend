from enum import Enum


class RegStagedState(Enum):
    IS_VERIFIED = "IS_VERIFIED"
    NON_FOUND = "NON_FOUND"
    NOT_VERIFIED = "NOT_VERIFIED"