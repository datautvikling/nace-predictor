from flask import request
from flask_restx import Namespace, fields, Resource

from app.domain.predictor.predictor import Prediction
from app.infrastructure.model_provider import get_predictor

AMOUNT_PARAM = "amount"
DEFAULT_AMOUNT = 5
THRESHOLD_PARAM = "threshold"
DEFAULT_THRESHOLD = 0

api = Namespace("v1", description="Predict NACE codes.")

prediction = api.model("Prediction", {
    "code": fields.String(description="The predicted NACE code."),
    "confidence": fields.Float(
        description="The confidence the model has in this prediction "
                    "(a decimal number between 0 and 1.0, representing 0% to 100%, "
                    "where 0 is very unlikely to be a good prediction, and 1.0 is most likely).")
})

meta = api.model("Meta", {
    "id": fields.String(description="The unique id of this prediction. "
                                    "Used to trace the prediction and its usage."),
    "model": fields.String(description="The unique id of the model used to make this prediction")
})

response_model = api.model("PredictionWithMetaInfo", {
    "predictions": fields.List(fields.Nested(prediction)),
    "meta": fields.Nested(meta)
})

request_model = api.model("PredictionRequest", {
    "text": fields.String(description="Text to get predictions for",
                          example="Produksjon, handel og tjenesteytelse innenfor databransjen, "
                                  "spesielt relatert til kunnskapsbaserte systemer.")
})


def to_model(pred: Prediction):
    """Convert a prediction to the API prediction model"""
    predictions = [{"code": code[0], "confidence": code[1]} for code in pred.predictions]

    return {
        "predictions": predictions,
        "meta": {
            "id": pred.meta.id,
            "model": pred.meta.model
        }
    }


@api.route("/prediction")
@api.doc(description="Predict NACE codes based on a provided description. "
                     "Predictions are delivered in order of confidence, with the best prediction first. "
                     "Use amount and threshold to control how many predictions to get, and what confidence "
                     "level to require for a prediction to be included. Note that these parameters interact: "
                     "If you set a threshold above 0, you may get less than the requested amount of predictions "
                     "if there are not enough predictions of the threshold confidence. "
         )
class Prediction(Resource):

    @staticmethod
    @api.marshal_with(response_model, mask=False)
    @api.expect(request_model)
    @api.param(AMOUNT_PARAM, "The amount of predictions to get", type="int", default=DEFAULT_AMOUNT)
    @api.param(THRESHOLD_PARAM, "The confidence threshold, excluding predictions below this value", type="float",
               default=DEFAULT_THRESHOLD)
    def post():
        text = request.json["text"]
        amount = _get_param(AMOUNT_PARAM, DEFAULT_AMOUNT, int)
        threshold = _get_param(THRESHOLD_PARAM, DEFAULT_THRESHOLD, float)
        return to_model(get_predictor().predict(text, amount, threshold))


def _get_param(name, default_value, type_converter):
    return type_converter(request.args[name]) if name in request.args else default_value
