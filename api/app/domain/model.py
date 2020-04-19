from dataclasses import dataclass
from enum import Enum
from typing import Any


class ModelType(Enum):
    fast_text = "FastText"


@dataclass(frozen=True)
class Model:
    """A model providing predictions"""
    type: ModelType

    name: str

    # If true, the model input text has been treated through NLP (tokenized, lemmatized, etc).
    # This means input to the predictor should be treated in a similar way for better results
    nlp: bool

    # The exact operation of the provided prediction library is so dependent on the underlying tech (e.g. FastText)
    # that it is impractical to type it exactly. Users of a model may know how to invoke the provided
    # prediction by examining the ModelType.
    prediction_provider: Any
