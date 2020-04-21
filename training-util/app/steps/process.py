import logging

import pandas as pd

from app.config import Config, ModelType
from app.constants import PREPROCESSED_DATA_FILE_NAME, PROCESSED_DATA_FILE_NAME, AKTIVITET_FIELD_NAME, NACE1_FIELD_NAME


def process(config: Config):
    """
    Process the data into the desired (algorithm-specific) format.
    """

    data = pd.read_csv(config.path_to(PREPROCESSED_DATA_FILE_NAME), dtype={"nace1": str})

    if config.samples:
        logging.debug(f"Sampling {config.samples} rows from preprocessed data")
        data = data.sample(n=config.samples)

    logging.debug("Labeling")

    if config.model_type == ModelType.fasttext:
        def row_labeler(row):
            # Fasttext reads the label per row as "__label__<label text>"
            return f"{row[AKTIVITET_FIELD_NAME]} __label__{row[NACE1_FIELD_NAME]}"

        labeled_data = data.apply(row_labeler, axis=1)
    else:  # Assume AutoML type
        labeled_data = data[[AKTIVITET_FIELD_NAME, NACE1_FIELD_NAME]].copy()

        # AutoML does not allow duplicate content, so keep only the first instance of a text
        labeled_data.drop_duplicates(subset="aktivitet", inplace=True)

        # AutoML requires at least 10 examples per label, so drop those with fewer occurrences.
        # This means we miss out on quite a few labels, which is unfortunate, but
        # these are also (probably) the labels least likely to occur in real use
        labeled_data = labeled_data[labeled_data.groupby(NACE1_FIELD_NAME)[AKTIVITET_FIELD_NAME].transform(len) > 10]

        # AutoML does not allow . in label texts, so replace with _
        labeled_data[NACE1_FIELD_NAME] = labeled_data[NACE1_FIELD_NAME].str.replace(".", "_")

    logging.debug(f"Processed to {len(labeled_data)} rows")

    logging.info("Storing as " + config.path_to(PROCESSED_DATA_FILE_NAME))

    labeled_data.to_csv(config.path_to(PROCESSED_DATA_FILE_NAME), header=False, index=False)
