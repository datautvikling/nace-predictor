from dataclasses import dataclass
from os import path


@dataclass(frozen=True)
class Config:

    working_dir: str

    def path_to(self, file_name: str) -> str:
        return path.join(self.working_dir, file_name)
