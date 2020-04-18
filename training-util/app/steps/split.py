import csv
import logging

import pandas as pd
from sklearn.model_selection import train_test_split

from app.config import Config, ModelType
from app.constants import PROCESSED_DATA_FILE_NAME, TRAINING_SET_FILE_NAME, TESTING_SET_FILE_NAME


def split(config: Config):
    """
    Split the data into training and testing sets.
    """

    if config.model_type == ModelType.automl:
        logging.debug("Skipping because of model type")
        return

    data = pd.read_csv(config.path_to(PROCESSED_DATA_FILE_NAME))

    testing_rate = 0.1

    logging.debug(f"Splitting into {(1 - testing_rate) * 100}% training, "
                  f"{testing_rate * 100}% testing")

    training_set, testing_set = train_test_split(data, test_size=testing_rate)

    logging.info("Storing training set as " + config.path_to(TRAINING_SET_FILE_NAME))
    training_set.to_csv(config.path_to(TRAINING_SET_FILE_NAME), encoding='utf-8', index=False,
                        quoting=csv.QUOTE_NONE)

    logging.info("Storing testing set as " + TESTING_SET_FILE_NAME)
    testing_set.to_csv(config.path_to(TESTING_SET_FILE_NAME), encoding='utf-8', index=False,
                       quoting=csv.QUOTE_NONE)
