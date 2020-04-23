import logging

import pandas as pd
from fasttext import load_model

from app.config import Config, ModelType
from app.constants import PREPROCESSED_DATA_FILE_NAME, MODEL_FILE_NAME, APPLY_TO_INPUT_FILE_NAME


def apply_to_input(config: Config):
    """
    Apply a trained model to the input itself.
    """

    if config.model_type == ModelType.automl:
        logging.debug("Skipping because of model type")
        return

    data = pd.read_csv(config.path_to(PREPROCESSED_DATA_FILE_NAME), dtype={"nace1": str})

    if config.samples:
        logging.debug(f"Sampling {config.samples} rows from preprocessed data")
        data = data.sample(n=config.samples)

    model = load_model(config.path_to(MODEL_FILE_NAME))

    logging.debug(f"Predicting {len(data)} rows")

    data["prediction"], data["confidence"] = zip(*data.apply(lambda x: predict(model, x["aktivitet"]), axis=1))

    disagreement = data[data["prediction"] != data["nace1"]].sort_values(by=["confidence"], ascending=False)

    strongly_disagree = disagreement[disagreement["confidence"] > 0.7]

    logging.info(f"Model 'disagrees' with {len(disagreement)} code assignments, "
                 f"{(len(disagreement) / len(data)) * 100}%. "
                 f"It 'strongly disagrees' (disagrees with over 70% probability) with {len(strongly_disagree)} "
                 f"assignments, {(len(strongly_disagree) / len(data)) * 100}%.")

    logging.info("Storing all disagreements as " + config.path_to(APPLY_TO_INPUT_FILE_NAME))
    disagreement.to_csv(config.path_to(APPLY_TO_INPUT_FILE_NAME), index=False)

    logging.info("Storing strong disagreements as " + config.path_to("disagrees.xlsx"))
    strongly_disagree.to_excel(config.path_to("disagrees.xlsx"), index=False)


def predict(model, text):
    label, confidence = model.predict(text)

    return label[0][9:], confidence[0]
