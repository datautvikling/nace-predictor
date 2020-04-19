import logging
import string

import pandas as pd
import spacy

from app.config import Config
from app.constants import ASSEMBLED_DATA_FILE_NAME, PREPROCESSED_DATA_FILE_NAME, AKTIVITET_FIELD_NAME, NACE1_FIELD_NAME

# Only load spaCy if needed
nlp = None


def preprocess(config: Config):
    """
    Perform cleaning and other pre-processing steps on the training data.

    This step should be algorithm-independent.
    """

    data = pd.read_csv(config.path_to(ASSEMBLED_DATA_FILE_NAME), dtype={NACE1_FIELD_NAME: str}).head(10000)

    logging.debug(f"Pre-processing {len(data)} rows")

    logging.debug("Dropping very short texts")
    data = data[data[AKTIVITET_FIELD_NAME].apply(lambda t: len(t) > 4)]

    if not config.nlp:
        logging.debug("Tokenizing")
        data["aktivitet"] = data[AKTIVITET_FIELD_NAME].map(_simple_tokenization)
    else:
        logging.debug("Tokenizing + lemmatizing with spaCy")

        global nlp
        # We don't need the parser, disabling it will increase performance
        # Enable/disable some parts for speed based on StackOverflow suggestions
        nlp = spacy.load("nb_core_news_sm", disable=["ner", "parser"])
        nlp.add_pipe(nlp.create_pipe("sentencizer"))

        data["aktivitet"] = data[AKTIVITET_FIELD_NAME].map(_lemmatize)

    logging.debug("Dropping 'konkursbo'")
    data = data[data[AKTIVITET_FIELD_NAME].apply(lambda t: t != "konkursbo")]

    logging.debug(f"Pre-processed to {len(data)} rows")

    logging.info("Storing as " + config.path_to(PREPROCESSED_DATA_FILE_NAME))

    data.to_csv(config.path_to(PREPROCESSED_DATA_FILE_NAME), index=False)


def _simple_tokenization(s: str) -> str:
    lower = s.lower()
    # This looks a bit weird - split and join twice to also remove any extra spaces added by weird
    # punctuation use, such as 'this , is a text !'
    no_punctuation = [word.translate(str.maketrans('', '', string.punctuation)) for word in lower.split()]

    return " ".join(" ".join(no_punctuation).split())


def _lemmatize(s: str) -> str:
    # Run a simple tokenizer first to lowercase, get rid of punctuation etc.
    # Could possibly disturb spaCy, consider moving later in the process
    tokenized = _simple_tokenization(s)

    tokens = []

    for token in nlp(tokenized):
        # Drop punctuation, numbers and "stop words" - the most common words of a language:
        # words that are probably not connected to the NACE code suited for the text
        if token.is_punct or token.like_num or token.is_stop:
            continue

        # spaCy does not attempt to lemmatize words it considers pronouns, so just keep their form as is
        if token.pos_ == "PRON":
            tokens.append(token.text)
        else:
            tokens.append(token.lemma_)

    return " ".join(" ".join(tokens).split())
