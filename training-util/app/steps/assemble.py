import logging

import pandas as pd

from app.config import Config
from app.constants import ENHET_FORMAAL_FILE_NAME, ENHET_NACE_FILE_NAME, ASSEMBLED_DATA_FILE_NAME


def assemble(config: Config):
    """Assemble raw input into training data"""

    logging.debug("Formatting and combining formaal and nace data")

    enhet_nace = _read_nace_data(config.path_to(ENHET_NACE_FILE_NAME))
    enhet_formaal = _read_formaal_data(config.path_to(ENHET_FORMAAL_FILE_NAME))

    logging.debug(f"Merging data")
    assembled = pd.merge(enhet_formaal, enhet_nace, on='orgnr', how='inner')

    logging.debug(f"{len(assembled)} enheter + NACE code assembled")

    logging.info("Storing as " + config.path_to(ASSEMBLED_DATA_FILE_NAME))

    assembled.to_csv(config.path_to(ASSEMBLED_DATA_FILE_NAME))


def _read_nace_data(file):
    logging.debug(f"Parsing " + file)
    # Make sure the NACE code isn't interpreted as a number
    data = pd.read_csv(file, sep="\t", dtype={"nacekode": str})

    sorted_codes = data.sort_values(by=["orgnr", "rekkefolge"])
    data = pd.pivot_table(sorted_codes,
                          index="orgnr",
                          columns="rekkefolge",
                          values="nacekode",
                          aggfunc="first").reset_index()
    data.columns = ["orgnr", "nace_1", "nace_2", "nace_3"]
    return data


def _read_formaal_data(file):
    logging.debug(f"Parsing " + file)
    data = pd.read_csv(file, sep="\t")

    # Parsing gives us an unwanted 4th column, drop it
    data.drop(["tekst"], axis=1, inplace=True)
    data.columns = ["orgnr", "linje_nr", "tekst"]

    data = data[["orgnr", "tekst"]].groupby("orgnr")["tekst"].apply(
        lambda x: " ".join(x)).reset_index()

    return data
