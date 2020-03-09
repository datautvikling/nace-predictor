import logging
from os import path

import requests

from app.config import Config
from app.constants import ENHET_NACE_FILE_NAME, ENHET_FORMAAL_FILE_NAME


def gather(config: Config):
    """Gather the raw input files required for training"""

    logging.debug("Gathering core data")

    _download_if_not_present(config.path_to(ENHET_NACE_FILE_NAME),
                             "https://schema.brreg.no/filer2018/nacekoder.tab")

    _download_if_not_present(config.path_to(ENHET_FORMAAL_FILE_NAME),
                             "https://schema.brreg.no/filer2018/formaal.tab")


def _download_if_not_present(local_file: str, remote_file: str):
    if path.exists(local_file):
        logging.debug(local_file + " already present")
        return

    open(local_file, "wb").write(requests.get(remote_file).content)
    logging.info("Downloaded " + local_file)
