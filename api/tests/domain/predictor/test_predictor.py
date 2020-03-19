import unittest
import uuid

from app.domain.predictor.predictor import clean, PredictionMetaInfo


class TestPredictor(unittest.TestCase):

    def test_cleans_strings(self):
        self.assertEqual("all cleaned up", clean("  all CLEANED up!!"))
        self.assertEqual("all cleaned up", clean("  all,"
                                                 " CLEANED up?"))


class TestPredictionMetaInfo(unittest.TestCase):

    def test_generates_uuid_when_no_id_provided(self):
        info = PredictionMetaInfo("name")
        self.assertIsNotNone(uuid.UUID(info.id))
