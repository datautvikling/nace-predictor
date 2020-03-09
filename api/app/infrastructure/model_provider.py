import json
from typing import Dict

from fasttext import load_model

from app.domain.model import ModelType, Model
from app.domain.predictor.fasttext_predictor import FastTextPredictor
from app.domain.predictor.predictor import Predictor

# Global value that holds the currently used model
_predictor = None


def get_predictor(configuration: Dict = None) -> Predictor:
    """
    Get the predictor for the current configuration (either provided to the function or read from file).
    Contains a prediction model and meta-info, such as the model name.

    Loads config, model etc. from file on the first invocation, and stores the result. Future invocations
    will return the predictor that was created on the first invocation (even if a new config is provided).

    :param configuration: a configuration dictionary. If none is provided, will read from the json file "config.json"
    expected to be found in the application root directory.
    :return: a predictor with a model.
    """
    global _predictor

    # TODO more specific errors
    if not _predictor:
        if configuration:
            _predictor = _load_predictor(configuration)
        else:
            with open("config.json") as json_file:
                _predictor = _load_predictor(json.load(json_file))

    return _predictor


def _load_predictor(config):
    model_config = config["model"]
    model_type = ModelType(model_config["type"])

    if not model_type == ModelType.fast_text:
        raise Exception("Only FastText is currently supported")

    if model_config["artifactType"] == "LocalFile":
        fast_text_model = load_model(model_config["artifactInfo"]["path"])
    else:
        raise Exception("Couldn't load model")

    model = Model(
        model_type,
        model_config["name"],
        fast_text_model
    )

    return FastTextPredictor(model)
