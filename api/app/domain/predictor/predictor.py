from __future__ import annotations

import uuid
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from typing import List, Tuple

from domain.model import Model


@dataclass(frozen=True)
class Prediction:
    """
    The result of a prediction.
    Contains the predicted NACE codes (with confidences) and additional meta information.
    """

    codes: List[Tuple[str, float]]
    meta: PredictionMetaInfo


@dataclass(frozen=True)
class PredictionMetaInfo:
    """Additional information about the prediction itself, such as the name of the model that produced it."""
    model: str
    id: str = field(default_factory=uuid.uuid4)


@dataclass(frozen=True)
class Predictor(ABC):
    """A predictor provides prediction services based on an ML model"""

    model: Model

    @abstractmethod
    def predict(self, text: str, amount: int) -> Prediction:
        """Make a prediction based on a provided text. Produce 'amount' predictions."""
        pass

    def model_name(self) -> str:
        """The unique name of the model used by this predictor"""
        return self.model.name
