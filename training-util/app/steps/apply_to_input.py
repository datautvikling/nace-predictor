import logging

import pandas as pd
from fasttext import load_model

from app.config import Config, ModelType
from app.constants import PREPROCESSED_DATA_FILE_NAME, MODEL_FILE_NAME


def apply_to_input(config: Config):
    """
    Apply a trained model to the input itself.
    """

    if config.model_type == ModelType.automl:
        logging.debug("Skipping because of model type")
        return

    original_input = pd.read_csv(config.path_to(PREPROCESSED_DATA_FILE_NAME), dtype={"nace1": str})

    if config.samples:
        logging.debug(f"Sampling {config.samples} rows from preprocessed data")
        original_input = original_input.sample(n=config.samples)

    model = load_model(config.path_to(MODEL_FILE_NAME))

    original_input["prediction"] = original_input.apply(lambda x: predict(model, x["aktivitet"]), axis=1)

    return


def predict(model, text):
    result = model.predict(text)

    return result[0][0][9:]
