import logging
import string

import pandas as pd

from app.config import Config
from app.constants import ASSEMBLED_DATA_FILE_NAME, PREPROCESSED_DATA_FILE_NAME


def preprocess(config: Config):
    """
    Perform cleaning and other pre-processing steps on the training data.

    This step should be algorithm-independent.
    """

    data = pd.read_csv(config.path_to(ASSEMBLED_DATA_FILE_NAME), dtype={'nace_1': str})

    logging.debug("Dropping short texts")
    data = data[data["tekst"].apply(lambda t: len(t) > 4)]

    logging.debug("Tokenizing")
    data["tekst"] = data["tekst"].map(lambda t: _tokenize(t))

    logging.debug(f"Pre-processed {len(data)} rows")

    logging.info("Storing as " + config.path_to(PREPROCESSED_DATA_FILE_NAME))

    data.to_csv(config.path_to(PREPROCESSED_DATA_FILE_NAME), index=False)


def _tokenize(s: str) -> str:
    lower = s.lower()
    split = lower.split()
    stripped = [word.translate(str.maketrans('', '', string.punctuation)) for word in split]

    return " ".join(stripped)
