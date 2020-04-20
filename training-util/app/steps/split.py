import csv
import logging

import numpy as np
import pandas as pd

from app.config import Config, ModelType
from app.constants import PROCESSED_DATA_FILE_NAME, TRAINING_SET_FILE_NAME, TESTING_SET_FILE_NAME, \
    VALIDATION_SET_FILE_NAME


def split(config: Config):
    """
    Split the data into training and testing sets.
    """

    if config.model_type == ModelType.automl:
        logging.debug("Skipping because of model type")
        return

    data = pd.read_csv(config.path_to(PROCESSED_DATA_FILE_NAME))

    if not config.hypertune_minutes:
        testing_rate = 0.1  # 10% of data for testing

        training_rate = 1 - testing_rate

        logging.debug(f"Splitting into {training_rate * 100}% training, "
                      f"{testing_rate * 100}% testing")

        train, test = np.split(data.sample(frac=1), [int(training_rate * len(data))])
    else:  # Assume hypertuning

        # We are hypertuning, so need both a validation and testing set

        # 10% of data for testing, 10% for validation
        testing_rate = 0.1
        validation_rate = 0.1

        training_rate = 1 - testing_rate - validation_rate

        logging.debug(f"Splitting into {training_rate * 100}% training, "
                      f"{testing_rate * 100}% testing, {validation_rate * 100}% validation")

        train, validate, test = np.split(
            data.sample(frac=1),
            [int(training_rate * len(data)), int((training_rate + validation_rate) * len(data))])

        logging.info("Storing validation set as " + config.path_to(VALIDATION_SET_FILE_NAME))
        validate.to_csv(config.path_to(VALIDATION_SET_FILE_NAME), encoding='utf-8', index=False,
                        quoting=csv.QUOTE_NONE)

    logging.info("Storing training set as " + config.path_to(TRAINING_SET_FILE_NAME))
    train.to_csv(config.path_to(TRAINING_SET_FILE_NAME), encoding='utf-8', index=False,
                 quoting=csv.QUOTE_NONE)

    logging.info("Storing testing set as " + TESTING_SET_FILE_NAME)
    test.to_csv(config.path_to(TESTING_SET_FILE_NAME), encoding='utf-8', index=False,
                quoting=csv.QUOTE_NONE)
