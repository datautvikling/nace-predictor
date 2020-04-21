from dataclasses import dataclass
from enum import Enum
from os import path
from typing import Optional


class InputType(Enum):
    csv = "csv"
    excel = "xls"


class ModelType(Enum):
    fasttext = "fasttext"
    automl = "automl"


@dataclass(frozen=True)
class Config:
    working_dir: str
    input_type: InputType
    samples: Optional[int]
    model_type: ModelType
    training_params_path: Optional[str]
    nlp: bool
    hypertune: bool
    quantize: bool

    def path_to(self, file_name: str) -> str:
        return path.join(self.working_dir, file_name)
