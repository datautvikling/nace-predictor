import logging

from fasttext import train_supervised

from app.config import Config, ModelType
from app.constants import TRAINING_SET_FILE_NAME, MODEL_FILE_NAME, VALIDATION_SET_FILE_NAME


def train(config: Config):
    """
    Train FastText model.
    """

    if config.model_type == ModelType.automl:
        logging.debug("Skipping because of model type")
        return

    if not config.hypertune_minutes:
        logging.debug("Training model")
        model = train_supervised(input=config.path_to(TRAINING_SET_FILE_NAME))
    else:
        logging.debug(f"Training model with {config.hypertune_minutes} minutes of hyperparameter optimization.")
        model = train_supervised(input=config.path_to(TRAINING_SET_FILE_NAME),
                                 autotuneValidationFile=config.path_to(VALIDATION_SET_FILE_NAME),
                                 autotuneDuration=config.hypertune_minutes*60,
                                 verbose=4)

        # todo store best params for future reuse

    logging.debug("Quantizing model")

    model.quantize()

    logging.info("Storing model as " + config.path_to(MODEL_FILE_NAME))

    model.save_model(config.path_to(MODEL_FILE_NAME))
