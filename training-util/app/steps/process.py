import logging

import pandas as pd

from app.config import Config
from app.constants import PREPROCESSED_DATA_FILE_NAME, PROCESSED_DATA_FILE_NAME


def process(config: Config):
    """
    Process the data into the desired (algorithm-specific) format.
    """

    data = pd.read_csv(config.path_to(PREPROCESSED_DATA_FILE_NAME), dtype={"nace_1": str})

    logging.debug("Labeling")

    labeled_data = data.apply(_tokenize_and_label_row, axis=1)

    logging.info("Storing as " + config.path_to(PROCESSED_DATA_FILE_NAME))

    labeled_data.to_csv(config.path_to(PROCESSED_DATA_FILE_NAME), header=False, index=False)


def _tokenize_and_label_row(row):
    # Fasttext reads the label per row as "__label__<label text>"
    return row["tekst"] + f" __label__{row['nace_1']}"
