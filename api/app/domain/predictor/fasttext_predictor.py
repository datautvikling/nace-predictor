from dataclasses import dataclass

from app.domain.predictor.predictor import Predictor, clean, Prediction, PredictionMetaInfo


@dataclass(frozen=True)
class FastTextPredictor(Predictor):

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
    """Removes the '__label__' from FastText predictions"""
    return label[9:]
