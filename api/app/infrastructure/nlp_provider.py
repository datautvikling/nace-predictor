import string

import spacy

# Only load spaCy if needed
nlp = None
# Some common words with little added meaning that can be considered stop words in the NLP
ADDITIONAL_STOP_WORDS = {"herunder", "samt", "hermed"}


# This function should match whatever cleaning is performed in the training process
def clean(s: str, full: bool = False) -> str:
    if not full:
        return simple_tokenization(s)

    # load if not already loaded
    if not nlp:
        load_nlp()

    tokenized = simple_tokenization(s)

    tokens = []

    for token in nlp(tokenized):
        if token.is_punct or token.like_num or token.is_stop:
            continue

        if token.pos_ == "PRON":
            tokens.append(token.text)
        else:
            tokens.append(token.lemma_)

    return " ".join(" ".join(tokens).split())


def load_nlp():
    global nlp

    if nlp:  # Already loaded?
        return

    # We don't need the parser, disabling it will increase performance
    # Enable/disable some parts for speed based on StackOverflow suggestions
    nlp = spacy.load("nb_core_news_sm", disable=["ner", "parser"])
    nlp.add_pipe(nlp.create_pipe("sentencizer"))
    nlp.Defaults.stop_words |= ADDITIONAL_STOP_WORDS


def simple_tokenization(s: str) -> str:
    lower = s.lower()
    # This looks a bit weird - split and join twice to also remove any extra spaces added by weird
    # punctuation use, such as 'this , is a text !'
    no_punctuation = [word.translate(str.maketrans('', '', string.punctuation)) for word in lower.split()]

    return " ".join(" ".join(no_punctuation).split())
