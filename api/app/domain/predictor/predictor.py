from __future__ import annotations

import string
import uuid
from abc import ABC, abstractmethod
from dataclasses import dataclass, field
from typing import List, Tuple

from app.domain.model import Model


@dataclass(frozen=True)
class Prediction:
    """
    The result of a prediction.
    Contains the predicted NACE codes (with confidences) and additional meta information.
    """

    predictions: List[Tuple[str, float]]
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
    def predict(self, text: str, amount: int, threshold: float) -> Prediction:
        """
        Make a prediction based on provided text.

        :param text: the text to predict based on.
        :param amount: the amount of predictions to get
        :param threshold: the threshold (0 - 1.0) of confidence required to include a specific prediction.
        :return: a prediction.
        """
        pass

    def model_name(self) -> str:
        """The unique name of the model used by this predictor"""
        return self.model.name


def clean(s: str) -> str:
    """'Clean' a string by removing punctuation, etc."""
    lower = s.lower()
    split = lower.split()
    stripped = [word.translate(str.maketrans('', '', string.punctuation)) for word in split]

    return " ".join(stripped)
