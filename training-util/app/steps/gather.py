import logging
from os import path

import requests

from app.config import Config, InputType
from app.constants import ENHET_NACE_CSV_FILE_NAME, ENHET_FORMAAL_CSV_FILE_NAME, NACE_EXCEL_FILE_NAME


def gather(config: Config):
    """Gather the raw input files required for training"""

    logging.debug("Gathering training data")

    if config.input_type == InputType.csv:
        _download_if_not_present(config.path_to(ENHET_NACE_CSV_FILE_NAME),
                                 "https://schema.brreg.no/filer2018/nacekoder.tab")

        _download_if_not_present(config.path_to(ENHET_FORMAAL_CSV_FILE_NAME),
                                 "https://schema.brreg.no/filer2018/formaal.tab")

    else:  # assuming excel file, so just confirm that it exists

        excel_path = config.path_to(NACE_EXCEL_FILE_NAME)
        if not _exists(excel_path):
            logging.error("Missing Excel input file at " + excel_path)
            raise RuntimeError


def _download_if_not_present(local_file: str, remote_file: str):
    if _exists(local_file):
        return

    open(local_file, "wb").write(requests.get(remote_file).content)
    logging.info("Downloaded " + local_file)


def _exists(file: str):
    if path.exists(file):
        logging.debug(file + " present")
        return True

    return False
