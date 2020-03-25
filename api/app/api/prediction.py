import json
import logging

from flask import request
from flask_restx import Namespace, fields, Resource

from app.domain.predictor.predictor import Prediction, PredictionDescription
from app.infrastructure.model_provider import get_predictor

ORGFORM_FIELD_NAME = "orgform"
TEXT_FIELD_NAME = "text"

ACTUAL_CODE_FIELD_NAME = "actualCode"
INDEX_FIELD_NAME = "index"

AMOUNT_PARAM = "amount"
DEFAULT_AMOUNT = 5
THRESHOLD_PARAM = "threshold"
DEFAULT_THRESHOLD = 0

api = Namespace("v1", description="Predict NACE codes.")

prediction = api.model("Prediction", {
    "code": fields.String(description="The predicted NACE code.", example="90.011"),
    "confidence": fields.Float(
        description="The confidence the model has in this prediction "
                    "(a decimal number between 0 and 1.0, representing 0% to 100%, "
                    "where 0 is very unlikely to be a good prediction, and 1.0 is most likely).",
        example="0.78")
})

meta = api.model("Meta", {
    "id": fields.String(description="The unique id of this prediction. "
                                    "Used to trace the prediction and its usage.",
                        example="9ee55f88-51f9-4891-ac1a-26751522a5b1")
})

pred_response_model = api.model("PredictionWithMetaInfo", {
    "predictions": fields.List(fields.Nested(prediction)),
    "meta": fields.Nested(meta)
})

pred_request_model = api.model("PredictionRequest", {
    TEXT_FIELD_NAME: fields.String(description="Text to get predictions for",
                                   example="Produksjon, handel og tjenesteytelse innenfor databransjen, "
                                           "spesielt relatert til kunnskapsbaserte systemer."),
    ORGFORM_FIELD_NAME: fields.String(description="Optional. Orgform code, where the code is the orgform we are"
                                                  " predicting for. May or may not be used to improve the prediction.",
                                      example="FLI")
})


def to_model(pred: Prediction):
    """Convert a prediction to the API prediction model"""
    predictions = [{"code": code[0], "confidence": code[1]} for code in pred.predictions]

    return {
        "predictions": predictions,
        "meta": {
            "id": pred.meta.id,
        }
    }


@api.route("/prediction")
@api.doc(description="Predict NACE codes based on a provided description. "
                     "Predictions are delivered in order of confidence, with the best prediction first. "
                     "Use amount and threshold to control how many predictions to get, and what confidence "
                     "level to require for a prediction to be included. Note that these parameters interact: "
                     "If you set a threshold above 0, you may get fewer than the requested amount of predictions "
                     "if there are not enough predictions with confidence above the threshold. ")
class Prediction(Resource):

    @staticmethod
    @api.marshal_with(pred_response_model, mask=False)
    @api.expect(pred_request_model)
    @api.param(AMOUNT_PARAM, "The amount of predictions to get", type="int", default=DEFAULT_AMOUNT)
    @api.param(THRESHOLD_PARAM, "The confidence threshold, excluding predictions below this value", type="float",
               default=DEFAULT_THRESHOLD)
    def post():
        text = request.json[TEXT_FIELD_NAME]
        orgform = request.json.get(ORGFORM_FIELD_NAME)
        amount = _get_param(AMOUNT_PARAM, DEFAULT_AMOUNT, int)
        threshold = _get_param(THRESHOLD_PARAM, DEFAULT_THRESHOLD, float)

        pred = get_predictor().predict(PredictionDescription(text, orgform), amount, threshold)
        result = to_model(pred)

        _log_prediction(text, orgform, amount, threshold, result)

        return result


usage_request_model = api.model("UsageRequest", {
    ACTUAL_CODE_FIELD_NAME: fields.String(),
    INDEX_FIELD_NAME: fields.Integer(
        description="Index of the prediction that was used. null if no prediction was used. "
                    "0-indexed, so a value of 0 means the first prediction was used, "
                    "3 means the fourth prediction was used, etc.",
        example=2)
})


@api.route("/usage/<string:id>")
@api.doc(description="Indicate that a specific prediction was used, and how it was used. "
                     "Clients should respond to this resource after requesting and using a "
                     "prediction from /prediction.")
@api.param("id", "ID of the prediction response that was used. This is the 'meta.id' field from the /prediction "
                 "resource response.")
class Usage(Resource):

    @staticmethod
    @api.expect(usage_request_model)
    @api.response(204, "The usage was successfully logged.")
    def post(id):
        actual_code = request.json[ACTUAL_CODE_FIELD_NAME]
        index = request.json.get(INDEX_FIELD_NAME)

        _log_usage(id, actual_code, index)

        return "", 204


def _get_param(name, default_value, type_converter):
    # Flask should be able to provide these as method params to the resource, but I couldn't get it to work properly
    return type_converter(request.args[name]) if name in request.args else default_value


def _log(dictionary):
    # Use JSON dumps to ensure we follow JSON standard (default print of dict uses single quotes, etc.)
    logging.info(json.dumps(dictionary))


def _log_prediction(text, orgform, amount, threshold, result):
    _log({
        "request": {
            "text": text,
            "orgform": orgform,
            "amount": amount,
            "threshold": threshold
        },
        "response": result
    })


def _log_usage(trace_id, actual_code, index):
    _log({
        "usage": {
            "id": trace_id,
            "actualCode": actual_code,
            "index": index
        }
    })
