import unittest
from dataclasses import dataclass
from typing import Any

from app.domain.model import Model, ModelType
from app.domain.predictor.fasttext_predictor import strip_prefix, LABEL_PREFIX, FastTextPredictor
from app.domain.predictor.predictor import PredictionDescription


@dataclass(frozen=True)
class DummyPredictionProvider:
    prediction: Any

    def predict(self, text, k=1, threshold=0.0):
        return self.prediction


class TestFastTextPredictor(unittest.TestCase):

    def test_structures_predictions_from_model(self):
        pred_1_code = "code1"
        pred_1_conf = 0.9

        pred_2_code = "label2"
        pred_2_conf = 0.2

        raw_prediction = ([LABEL_PREFIX + pred_1_code, LABEL_PREFIX + pred_2_code], [pred_1_conf, pred_2_conf])

        dummy_model = Model(ModelType.fast_text, "dummy model", False, DummyPredictionProvider(raw_prediction))

        actual_prediction = FastTextPredictor(dummy_model).predict(PredictionDescription("just a test!"), 5, 0)

        expected_predictions = [(pred_1_code, pred_1_conf), (pred_2_code, pred_2_conf)]

        self.assertEqual(expected_predictions, actual_prediction.predictions)

    def text_prediction_adds_meta_info(self):
        dummy_model = Model(ModelType.fast_text, "dummy model", False, DummyPredictionProvider(([], [])))

        actual_prediction = FastTextPredictor(dummy_model).predict(PredictionDescription("just a test!"), 5, 0)

        actual_meta_info = actual_prediction.meta

        self.assertEqual(dummy_model.name, actual_meta_info.model)
        self.assertIsNotNone(actual_meta_info.id)

    def test_strips_label_prefix(self):
        label = LABEL_PREFIX
        text = "This is a prediction"
        text_with_label = label + text
        self.assertEqual(text, strip_prefix(text_with_label))
