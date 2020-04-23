import logging
from argparse import ArgumentParser
from pathlib import Path
from typing import List

from app.config import Config, ModelType, InputType
from app.steps.apply_to_input import apply_to_input
from app.steps.assemble import assemble
from app.steps.gather import gather
from app.steps.preprocess import preprocess
from app.steps.process import process
from app.steps.split import split
from app.steps.test import test
from app.steps.train import train

ALL_STEPS = [
    ("gather", gather),
    ("assemble", assemble),
    ("preprocess", preprocess),
    ("process", process),
    ("split", split),
    ("train", train),
    ("test", test),
    ("apply-to-input", apply_to_input)
]


def main(from_step: str, to_step: str, step_config: Config):
    def step_index(step_name):
        return next(i for i, step in enumerate(ALL_STEPS) if step[0] == step_name)

    starting_index = step_index(from_step)
    stopping_index = 1 + step_index(to_step) if to_step else len(ALL_STEPS)

    steps_to_run = ALL_STEPS[starting_index:stopping_index]

    logging.debug("Will run steps: " + ", ".join([step[0] for step in steps_to_run]))

    for name, step in steps_to_run:
        logging.info(f"Running the {name} step")
        step(step_config)


def parse_arguments(step_names: List[str]):
    parser = ArgumentParser(description="Utility for training ML models for NACE code classification.")

    parser.add_argument("--working-dir",
                        action="store", default="data",
                        help="Set the directory to read and write files in, relative to where the util is run. "
                             + "Default is 'data'.")
    parser.add_argument("--input-type",
                        action="store", choices=["csv", "xls"], default="csv",
                        help="Training data input type. Either two downloadable csv files, or a "
                             "complete Excel (xls) file which must be provided in the working dir. "
                             "Default is 'csv'.")
    parser.add_argument("--samples",
                        action="store", type=int, default=None,
                        help="How many enhet samples to make from the input. If none is set (which is the default),"
                             " all data will be used.")
    parser.add_argument("--model-type",
                        action="store", choices=["fasttext", "automl"], default="fasttext",
                        help="The type of model to train (or prepare data for). Default is 'fasttext'.")
    parser.add_argument("--training-params",
                        action="store", type=str, default=None,
                        help="A JSON file (path relative to the working directory) containing training parameters. "
                             "These parameters will be used during model training. Default is to not read any "
                             "parameters, using the model default values.")
    parser.add_argument("--nlp",
                        action="store_true",
                        help="If set, do NLP-based processing of the input text (lemmatize, drop stop words, etc.). "
                             "If not set, only basic tokenization is done (which is much quicker), default behaviour.")
    parser.add_argument("--hypertune",
                        action="store_true",
                        help="Perform hyperparameter optimization if supported by the model. "
                             "This process may take a long time, but can be stopped by sending SIGINT (ctrl+C), "
                             "and the best result thus far will be used. The parameters are stored as "
                             "'training_params.json' in the working directory, and may be reused for training with the "
                             "--training-params argument. Note that params provided by the --training-params "
                             "argument will not be used when hypertuning is enabled.")
    parser.add_argument("--quantize",
                        action="store_true",
                        help="Quantize the trained model, greatly reducing its size. The process takes time.")
    parser.add_argument("--from-step",
                        action="store", choices=step_names, default=step_names[0],
                        help="Set the step to start from, skipping those that precede it.")
    parser.add_argument("--to-step",
                        action="store", choices=step_names, default=None,
                        help="Set the step to run to (inclusive), skipping those that come after it.")
    parser.add_argument("--log-level",
                        action="store", choices=["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"], default="INFO",
                        help="Set the log threshold level. Default is INFO.")

    return parser.parse_args()


if __name__ == '__main__':
    args = parse_arguments([step[0] for step in ALL_STEPS])

    config = Config(args.working_dir, InputType(args.input_type), args.samples, ModelType(args.model_type),
                    args.training_params, args.nlp, args.hypertune, args.quantize)

    # Make sure the working dir exists
    Path(args.working_dir).mkdir(parents=True, exist_ok=True)

    logging.basicConfig(
        format="%(asctime)s %(filename)-20s [%(levelname)-8s] %(message)s",
        level=getattr(logging, args.log_level.upper(), None),
        handlers=[
            logging.FileHandler(config.path_to("training.log")),
            logging.StreamHandler(),
        ]
    )

    main(args.from_step, args.to_step, config)
