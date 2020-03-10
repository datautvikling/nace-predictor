from api.app.domain.predictor.predictor import Predictor, Prediction, PredictionMetaInfo


class DummyPredictor(Predictor):

    def predict(self, text, amount):
        return Prediction(
            [("10.123", 0.5), ("55.123", 0.3)],
            PredictionMetaInfo(self.model_name())
        )

    def model_name(self) -> str:
        return "A dummy model"
