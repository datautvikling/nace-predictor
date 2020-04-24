from dataclasses import dataclass

from app.domain.predictor.predictor import Predictor, clean, PredictionMetaInfo, Prediction


@dataclass(frozen=True)
class AutoMLPredictor(Predictor):
    """A predictor using an AutoML model"""

    def predict(self, description, amount, threshold):
        cleaned_text = clean(description.text)

        prediction_payload = self.model.prediction_provider.predict(cleaned_text).payload

        predictions = []

        for pred in prediction_payload[:amount]:
            # AutoML does not like . in labels, so it has been replaced by _
            # Swap it back before providing to client
            code = pred.display_name.replace("_", ".")
            confidence = pred.classification.score

            if confidence < threshold:
                # Results are ordered by confidence (highest first), so if we encounter anything
                # below the threshold we can stop iterating
                break

            predictions.append((code, confidence))

        return Prediction(predictions, PredictionMetaInfo(self.model_name()))
