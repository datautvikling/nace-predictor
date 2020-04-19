import unittest
import uuid

from app.domain.predictor.predictor import PredictionMetaInfo


class TestPredictionMetaInfo(unittest.TestCase):

    def test_generates_uuid_when_no_id_provided(self):
        info = PredictionMetaInfo("name")
        self.assertIsNotNone(uuid.UUID(info.id))
