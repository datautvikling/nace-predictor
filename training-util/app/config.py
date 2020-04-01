from dataclasses import dataclass
from enum import Enum
from os import path


class ModelType(Enum):
    fasttext = "fasttext"
    automl = "automl"


@dataclass(frozen=True)
class Config:
    working_dir: str
    type: ModelType

    def path_to(self, file_name: str) -> str:
        return path.join(self.working_dir, file_name)
