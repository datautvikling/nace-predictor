from dataclasses import dataclass
from enum import Enum
from typing import Any


class ModelType(Enum):
    fast_text = "FastText"


@dataclass(frozen=True)
class Model:
    type: ModelType
    name: str
    prediction_provider: Any
