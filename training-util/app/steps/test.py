import logging

import math
import pandas as pd
from fasttext import load_model

from app.config import Config, ModelType
from app.constants import MODEL_FILE_NAME, TESTING_SET_FILE_NAME, TEST_RESULTS_FILE_NAME


def test(config: Config):
    """
    Test a FastText model.
    """

    if config.model_type == ModelType.automl:
        logging.debug("Skipping because of model type")
        return

    model = load_model(config.path_to(MODEL_FILE_NAME))
    logging.debug("Testing model")

    logging.debug(f"{len(model.get_words())} words")
    logging.debug(f"{len(model.get_labels())} labels")

    samples, precision, recall = model.test(config.path_to(TESTING_SET_FILE_NAME))

    logging.debug(f"Overall precision is {precision}")

    logging.debug("Running detailed FastText testing")

    label_results = model.test_label(config.path_to(TESTING_SET_FILE_NAME))

    transformed_results = [[label[9:], 0 if math.isnan(r["precision"]) else r["precision"], r["recall"], r["f1score"]]
                           for label, r in label_results.items()]

    tested_results = [result for result in transformed_results if not math.isnan(result[3])]
    untested_labels = [result[0] for result in transformed_results if math.isnan(result[3])]

    logging.debug(f"{len(untested_labels)} labels not present in test set")

    test_df = pd.DataFrame(tested_results)
    test_df.columns = ["label", "precision", "recall", "accuracy"]
    test_df.sort_values(by="label", inplace=True)

    logging.debug(f"{len(test_df[test_df['accuracy'] == 0])} labels with no prediction hit")

    means = test_df[test_df["accuracy"] != 0].mean()

    logging.debug("Mean for labels with prediction (precision, recall, accuracy):")
    logging.debug(means["precision"])
    logging.debug(means["recall"])
    logging.debug(means["accuracy"])

    logging.info("Storing test results as " + TEST_RESULTS_FILE_NAME)
    test_df.to_csv(config.path_to(TEST_RESULTS_FILE_NAME), index=False, sep=" ")
