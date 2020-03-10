import logging
from argparse import ArgumentParser
from pathlib import Path
from typing import List

from config import Config
from steps.assemble import assemble
from steps.gather import gather
from steps.preprocess import preprocess
from steps.process import process
from steps.split import split
from steps.test import test
from steps.train import train

ALL_STEPS = [
    ("gather", gather),
    ("assemble", assemble),
    ("preprocess", preprocess),
    ("process", process),
    ("split", split),
    ("train", train),
    ("test", test)
]


def main(from_step: str, to_step: str, step_config: Config):
    def step_index(step_name):
        return next(i for i, step in enumerate(ALL_STEPS) if step[0] == step_name)

    starting_index = step_index(from_step)
    stopping_index = 1 + step_index(to_step) if to_step else len(ALL_STEPS)

    steps_to_run = ALL_STEPS[starting_index:stopping_index]

    logging.debug("Will run steps: " + ", ".join([step[0] for step in steps_to_run]))

    for name, step in steps_to_run:
        logging.info("Running step " + name)
        step(step_config)


def parse_arguments(step_names: List[str]):
    parser = ArgumentParser(description="Utility for training ML models for NACE code classification.")

    parser.add_argument("--working-dir",
                        action="store", default="data",
                        help="Set the directory to read and write files in, relative to where the util is run. "
                             + "Default is 'data'.")
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

    config = Config(args.working_dir)
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
