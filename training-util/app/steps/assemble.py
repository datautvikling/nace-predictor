import logging

import pandas as pd
from pandas import DataFrame

from app.config import Config, InputType
from app.constants import ENHET_FORMAAL_CSV_FILE_NAME, ENHET_NACE_CSV_FILE_NAME, ASSEMBLED_DATA_FILE_NAME, \
    NACE_EXCEL_FILE_NAME


def assemble(config: Config):
    """Assemble raw input into training data"""

    assembler = read_and_combine_csv if config.input_type == InputType.csv else read_excel

    assembled_data = assembler(config)

    logging.debug(f"{len(assembled_data)} org with NACE codes assembled")

    logging.info("Storing as " + config.path_to(ASSEMBLED_DATA_FILE_NAME))

    assembled_data.to_csv(config.path_to(ASSEMBLED_DATA_FILE_NAME))


def read_excel(config: Config) -> DataFrame:
    logging.debug("Parsing Excel document")

    data = pd.read_excel(config.path_to(NACE_EXCEL_FILE_NAME))
    logging.debug(f"Read {len(data)} lines from Excel file")

    # Some cells may be parsed as empty, set these to some string to allow the grouping to work
    data = data.fillna(" ")

    data = data.groupby(["orgnr", "nace1", "nace2", "nace3"])["aktivitet"] \
        .apply(lambda x: " ".join(x)).reset_index()

    return data


def read_and_combine_csv(config: Config) -> DataFrame:
    logging.debug("Parsing and combining formaal and nace CSV files")

    enhet_nace = _read_nace_data(config.path_to(ENHET_NACE_CSV_FILE_NAME))
    enhet_formaal = _read_formaal_data(config.path_to(ENHET_FORMAAL_CSV_FILE_NAME))

    logging.debug(f"Merging data")

    return pd.merge(enhet_formaal, enhet_nace, on='orgnr', how='inner')


def _read_nace_data(file):
    logging.debug("Parsing " + file)
    # Make sure the NACE code isn't interpreted as a number
    data = pd.read_csv(file, sep="\t", dtype={"nacekode": str})

    sorted_codes = data.sort_values(by=["orgnr", "rekkefolge"])
    data = pd.pivot_table(sorted_codes,
                          index="orgnr",
                          columns="rekkefolge",
                          values="nacekode",
                          aggfunc="first").reset_index()
    data.columns = ["orgnr", "nace1", "nace2", "nace3"]
    return data


def _read_formaal_data(file):
    logging.debug("Parsing " + file)
    data = pd.read_csv(file, sep="\t")

    # Parsing gives us an unwanted 4th column, drop it
    data.drop(["tekst"], axis=1, inplace=True)
    data.columns = ["orgnr", "linje_nr", "aktivitet"]

    data = data[["orgnr", "aktivitet"]].groupby("orgnr")["aktivitet"].apply(
        lambda x: " ".join(x)).reset_index()

    return data
