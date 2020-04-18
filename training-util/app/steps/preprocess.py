import logging
import string

import pandas as pd

from app.config import Config
from app.constants import ASSEMBLED_DATA_FILE_NAME, PREPROCESSED_DATA_FILE_NAME, AKTIVITET_FIELD_NAME, NACE1_FIELD_NAME


def preprocess(config: Config):
    """
    Perform cleaning and other pre-processing steps on the training data.

    This step should be algorithm-independent.
    """

    data = pd.read_csv(config.path_to(ASSEMBLED_DATA_FILE_NAME), dtype={NACE1_FIELD_NAME: str})

    logging.debug("Dropping short texts")
    data = data[data[AKTIVITET_FIELD_NAME].apply(lambda t: len(t) > 4)]

    logging.debug("Tokenizing")
    data["aktivitet"] = data[AKTIVITET_FIELD_NAME].map(_tokenize)

    logging.debug("Dropping 'konkursbo'")
    data = data[data[AKTIVITET_FIELD_NAME].apply(lambda t: t != "konkursbo")]

    logging.debug(f"Pre-processed to {len(data)} rows")

    logging.info("Storing as " + config.path_to(PREPROCESSED_DATA_FILE_NAME))

    data.to_csv(config.path_to(PREPROCESSED_DATA_FILE_NAME), index=False)


def _tokenize(s: str) -> str:
    lower = s.lower()
    # This looks a bit weird - split and join twice to also remove any extra spaces added by weird
    # punctuation use, such as 'this , is a text !'
    no_punctuation = [word.translate(str.maketrans('', '', string.punctuation)) for word in lower.split()]

    return " ".join(" ".join(no_punctuation).split())
