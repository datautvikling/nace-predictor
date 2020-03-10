from flask import request
from flask_restx import Namespace, fields, Resource

from domain.predictor.predictor import Prediction
from infrastructure.model_provider import get_predictor

api = Namespace("v1", description="Predict NACE codes.")

prediction = api.model("Prediction", {
    "code": fields.String(description="The predicted NACE code."),
    "confidence": fields.Float(
        description="The confidence the model has in this prediction "
                    "(a decimal number between 0 and 1.0, representing 0% to 100%).")
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
                     "Predictions are delivered in order of confidence, with the best prediction first. ")
class Predictor(Resource):

    @staticmethod
    @api.marshal_with(response_model, mask=False)
    @api.expect(request_model)
    @api.param("amount", "The amount of predictions to get", type="int", default=5)
    def post():
        text = request.json["text"]
        amount = int(request.args["amount"])
        return to_model(get_predictor().predict(text, amount))
