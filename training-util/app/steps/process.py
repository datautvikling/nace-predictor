import logging

import pandas as pd

from app.config import Config, ModelType
from app.constants import PREPROCESSED_DATA_FILE_NAME, PROCESSED_DATA_FILE_NAME


def process(config: Config):
    """
    Process the data into the desired (algorithm-specific) format.
    """

    data = pd.read_csv(config.path_to(PREPROCESSED_DATA_FILE_NAME), dtype={"nace_1": str})

    logging.debug("Labeling")

    if config.type == ModelType.fasttext:
        def row_labeler(row):
            # Fasttext reads the label per row as "__label__<label text>"
            return row["tekst"] + f" __label__{row['nace_1']}"

        labeled_data = data.apply(row_labeler, axis=1)
    else:  # Assume AutoML type
        labeled_data = data[["tekst", "nace_1"]].copy()
        # AutoML does not allow . in label texts, so replace with _
        labeled_data["nace_1"] = labeled_data["nace_1"].str.replace(".", "_")
        # AutoML does not allow duplicate content, so keep only the first instance of a text
        labeled_data.drop_duplicates(subset="tekst", inplace=True)

    logging.info("Storing as " + config.path_to(PROCESSED_DATA_FILE_NAME))

    labeled_data.to_csv(config.path_to(PROCESSED_DATA_FILE_NAME), header=False, index=False)
