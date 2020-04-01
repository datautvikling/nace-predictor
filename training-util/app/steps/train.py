import logging

from fasttext import train_supervised

from app.config import Config, ModelType
from app.constants import TRAINING_SET_FILE_NAME, MODEL_FILE_NAME


def train(config: Config):
    """
    Train FastText model.
    """

    if config.type == ModelType.automl:
        logging.debug("Skipping because of model type")
        return

    logging.debug("Training model")
    model = train_supervised(input=config.path_to(TRAINING_SET_FILE_NAME))

    logging.debug("Quantizing model")

    model.quantize()

    logging.info("Storing model as " + config.path_to(MODEL_FILE_NAME))

    model.save_model(config.path_to(MODEL_FILE_NAME))
