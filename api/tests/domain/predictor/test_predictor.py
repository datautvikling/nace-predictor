import unittest

from app.domain.predictor.predictor import clean


class TestPredictor(unittest.TestCase):

    def test_cleans_strings(self):

        self.assertEqual("all cleaned up", clean("  all CLEANED up!!"))
        self.assertEqual("all cleaned up", clean("  all,"
                                                 " CLEANED up?"))
