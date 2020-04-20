import json
import logging

from fasttext import train_supervised

from app.config import Config, ModelType
from app.constants import TRAINING_SET_FILE_NAME, MODEL_FILE_NAME, VALIDATION_SET_FILE_NAME

training_params = ["epoch", "lr", "dim", "minCount", "wordNgrams", "minn", "maxn", "bucket"]


def train(config: Config):
    """
    Train FastText model.
    """

    if config.model_type == ModelType.automl:
        logging.debug("Skipping because of model type")
        return

    training_file = config.path_to(TRAINING_SET_FILE_NAME)

    if not config.hypertune:
        if not config.training_params_path:
            logging.debug("Training model with default parameters")
            model = train_supervised(input=training_file)
        else:
            params_file_path = config.path_to(config.training_params_path)
            logging.debug("Reading parameters from " + params_file_path)
            with open(params_file_path) as params_file:
                params = json.load(params_file)

                logging.debug("Training model with parameters: ")
                for name, value in params.items():
                    logging.debug(f"    {name} = {value}")

                model = train_supervised(input=training_file, **params)
    else:
        logging.debug("Training model with hyperparameter optimization.")
        logging.debug("Press CTRL+C at any time to train with the best parameters found so far.")
        model = train_supervised(input=training_file, autotuneValidationFile=config.path_to(VALIDATION_SET_FILE_NAME))

        training_params_file_path = config.path_to("training_params.json")
        logging.info("Storing training parameters as " + training_params_file_path)
        _log_params(model.f.getArgs(), training_params_file_path)

    if config.quantize:
        logging.debug("Quantizing model")
        model.quantize()

    logging.info("Storing model as " + config.path_to(MODEL_FILE_NAME))
    model.save_model(config.path_to(MODEL_FILE_NAME))


def _log_params(args, path):
    params = {param: getattr(args, param) for param in training_params if hasattr(args, param)}

    with open(path, "w", encoding="utf-8") as file:
        json.dump(params, file)
