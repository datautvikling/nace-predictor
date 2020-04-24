from dataclasses import dataclass

from app.domain.predictor.predictor import Predictor, clean, PredictionMetaInfo


@dataclass(frozen=True)
class AutoMLPredictor(Predictor):
    """A predictor using an AutoML model"""

    def predict(self, description, amount, threshold):
        cleaned_text = clean(description.text)

        meta_info = PredictionMetaInfo(self.model_name())

        predictions = self.model.prediction_provider.predict(description.text, amount, threshold)

        return predictions


