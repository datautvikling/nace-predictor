import json
from typing import Dict

from fasttext import load_model
from google.cloud import storage

from app.domain.model import ModelType, Model
from app.domain.predictor.fasttext_predictor import FastTextPredictor
from app.domain.predictor.predictor import Predictor

# Global value that holds the currently used predictor
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
    artifact_type = model_config["artifactType"]

    if not model_type == ModelType.fast_text:
        raise ModelLoadingException("Only model type FastText is currently supported")

    if artifact_type == "LocalFile":
        path = model_config["artifactInfo"]["path"]
    elif artifact_type == "GCPStorage":
        gcp_path = model_config["artifactInfo"]["path"]

        path = "data/model.bin"
        with open(path, 'ab') as file:  # We don't expect this file to already exist, so create it to prepare download
            storage.Client().download_blob_to_file(gcp_path, file)
    else:
        raise ModelLoadingException(f"Could not load unknown artifact type '{artifact_type}'")

    model = Model(
        model_type,
        model_config["name"],
        load_model(path)
    )

    return FastTextPredictor(model)


class ModelLoadingException(Exception):

    def __init__(self, message):
        super().__init__(message)
