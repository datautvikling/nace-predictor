from flask import request
from flask_restx import Resource, Namespace, fields

from app.domain.predictor.predictor import Prediction, PredictionDescription
from app.infrastructure.model_provider import get_predictor

api = Namespace("v0", description="Predict NACE codes by text (deprecated)")

model = api.model("DeprecatedPrediction", {
    "nace": fields.String(description="The predicted NACE code."),
    "value": fields.Float(description="The confidence the model has in this prediction "
                                      "(a decimal number between 0 and 1.0, representing 0% to 100%).")
})


def to_model(prediction: Prediction):
    """Convert a prediction to the API prediction model"""
    return [{"nace": code[0], "value": code[1]} for code in prediction.predictions]


@api.route("/api")
@api.doc(description="Predict NACE codes based on a provided text. "
                     "Predictions are delivered in order of confidence, with the best prediction first. "
                     "This resource is deprecated and only available for compatibility concerns "
                     "- use /v1/prediction instead.")
class DeprecatedPrediction(Resource):

    @staticmethod
    @api.deprecated
    @api.doc(security=None)
    @api.marshal_with(model, as_list=True, mask=False)
    @api.param("q", "The text to predict a NACE code for", type="string")
    def get():
        q = request.args["q"]  # I would much prefer to receive this as an argument, but that's apparently not easy
        return to_model(get_predictor().predict(PredictionDescription(q), 5, 0))
