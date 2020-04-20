import json
import logging

from fasttext import train_supervised

from app.config import Config, ModelType
from app.constants import TRAINING_SET_FILE_NAME, MODEL_FILE_NAME, VALIDATION_SET_FILE_NAME

training_params = ["epoch", "lr", "dim", "minCount", "wordNgrams", "minn", "maxn", "bucket", "dsub"]


def train(config: Config):
    """
    Train FastText model.
    """

    if config.model_type == ModelType.automl:
        logging.debug("Skipping because of model type")
        return

    if not config.hypertune:
        logging.debug("Training model")
        model = train_supervised(input=config.path_to(TRAINING_SET_FILE_NAME))
    else:
        logging.debug(f"Training model with hyperparameter optimization.")
        model = train_supervised(input=config.path_to(TRAINING_SET_FILE_NAME),
                                 autotuneValidationFile=config.path_to(VALIDATION_SET_FILE_NAME),
                                 verbose=4)

        training_params_file_path = config.path_to("training_params.json")
        logging.info("Storing training parameters as " + training_params_file_path)
        _log_params(model.f.getArgs(), training_params_file_path)

    logging.debug("Quantizing model")
    model.quantize()

    logging.info("Storing model as " + config.path_to(MODEL_FILE_NAME))
    model.save_model(config.path_to(MODEL_FILE_NAME))


def _log_params(args, path):
    params = {param: getattr(args, param) for param in training_params if hasattr(args, param)}

    with open(path, "w", encoding="utf-8") as file:
        json.dump(params, file)
