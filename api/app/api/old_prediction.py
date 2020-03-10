from flask import request
from flask_restx import Resource, Namespace, fields

from domain.predictor.predictor import Prediction
from infrastructure.model_provider import get_predictor

old_api = Namespace("v0/api", description="Predict NACE codes by text (deprecated)")

model = old_api.model("Prediction", {
    "nace": fields.String(description="The predicted NACE code."),
    "value": fields.Float(description="The confidence the model has in this prediction "
                                      "(a decimal number between 0 and 1.0, representing 0% to 100%).")
})


def to_model(prediction: Prediction):
    """Convert a prediction to the API prediction model"""
    return [{"nace": code[0], "value": code[1]} for code in prediction.codes]


@old_api.route("")
@old_api.doc(
    description="Predict NACE codes based on a provided text. "
                "Predictions are delivered in order of confidence, with the best prediction first. "
                "This resource is deprecated - use -something- instead.")
class OldPredictor(Resource):

    @staticmethod
    @old_api.marshal_with(model, as_list=True, mask=False)
    @old_api.param("q", "The text to predict a NACE code for", type="string")
    def get():
        # TODO clean up input (lowercase, remove punctuation etc)
        q = request.args["q"]  # I would much prefer to receive this as an argument, but that's apparently not easy
        return to_model(get_predictor().predict(q, 5))
