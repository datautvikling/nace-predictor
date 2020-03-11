from dataclasses import dataclass

from app.domain.predictor.predictor import Predictor, clean, Prediction, PredictionMetaInfo


@dataclass(frozen=True)
class FastTextPredictor(Predictor):

    def predict(self, text, amount, threshold):
        cleaned_text = clean(text)

        predictions = [(strip_prefix(code), confidence) for code, confidence
                       in zip(*self.model.prediction_provider.predict(cleaned_text, k=amount, threshold=threshold))]

        return Prediction(predictions, PredictionMetaInfo(self.model_name()))


def strip_prefix(label: str) -> str:
    """Removes the '__label__' from FastText predictions"""
    return label[9:]
