from enum import Enum


class KycVerificationState(Enum):
    IN_REVIEW = "IN_REVIEW"
    ACCEPTED = "ACCEPTED"
    NOT_STARTED = "NOT_STARTED"
    REJECTED = "REJECTED"