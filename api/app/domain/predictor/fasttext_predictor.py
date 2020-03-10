from dataclasses import dataclass

from domain.predictor.predictor import Predictor, Prediction, PredictionMetaInfo, clean


@dataclass(frozen=True)
class FastTextPredictor(Predictor):

    def predict(self, text, amount):
        cleaned_text = clean(text)

        predictions = [(strip_prefix(code), confidence) for code, confidence
                       in zip(*self.model.prediction_provider.predict(cleaned_text, k=amount))]

        return Prediction(predictions, PredictionMetaInfo(self.model_name()))


def strip_prefix(label: str) -> str:
    """Removes the '__label__' from FastText predictions"""
    return label[9:]
