from dataclasses import dataclass

from app.domain.predictor.predictor import Predictor, clean, Prediction, PredictionMetaInfo

LABEL_PREFIX = "__label__"


@dataclass(frozen=True)
class FastTextPredictor(Predictor):
    """A predictor using a FastText model"""

    def predict(self, text, amount, threshold):
        cleaned_text = clean(text)

        meta_info = PredictionMetaInfo(self.model_name())

        try:
            raw_predictions = self.model.prediction_provider.predict(cleaned_text, k=amount, threshold=threshold)
            predictions = [(strip_prefix(code), confidence) for code, confidence in zip(*raw_predictions)]
            return Prediction(predictions, meta_info)
        except ValueError:
            # Annoyingly, the FastText lib actually crashes when there are no predictions above the threshold
            # (which isn't unlikely to happen if the input is poor or unexpected)
            return Prediction([], meta_info)


def strip_prefix(label: str) -> str:
    """Removes the prefix from FastText predictions"""
    return label[len(LABEL_PREFIX):]
