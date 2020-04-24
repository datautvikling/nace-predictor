import json
from dataclasses import dataclass
from typing import Dict

from fasttext import load_model as load_fasttext_model
from google.cloud import storage
from google.cloud.automl_v1beta1 import PredictionServiceClient

from app.domain.model import ModelType, Model
from app.domain.predictor.automl_predictor import AutoMLPredictor
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

    if model_type == ModelType.fast_text:
        return _load_fasttext_predictor(model_type, model_config)
    else:  # AutoML
        return _load_automl_predictor(model_type, model_config)


def _load_fasttext_predictor(model_type, model_config):
    artifact_type = model_config["artifactType"]

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
        load_fasttext_model(path)
    )

    return FastTextPredictor(model)


class AutoMLAPIWrapper:

    def __init__(self, project, location, automl_model_name):
        # The default client behaviour excepts a global model, set the specific EU endpoint for EU models
        self.client = PredictionServiceClient(client_options={"api_endpoint": "eu-automl.googleapis.com:443"})
        self.path = PredictionServiceClient.model_path(project, location, automl_model_name)

    def predict(self, text):
        payload = {"text_snippet": {"content": text, "mime_type": "text/plain"}}
        predictions = self.client.predict(self.path, payload)
        print(predictions)
        return predictions


def _load_automl_predictor(model_type, model_config):
    artifact = model_config["artifactInfo"]

    model = Model(
        model_type,
        model_config["name"],
        AutoMLAPIWrapper(artifact["project"], artifact["location"], artifact["id"])
    )

    return AutoMLPredictor(model)


class ModelLoadingException(Exception):

    def __init__(self, message):
        super().__init__(message)
