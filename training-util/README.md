# Training utility

A utility application for training ML models for NACE code classification.

Its main purpose is to run in an automated process, automatically gathering and processing data to train a model
without any necessary preparation.

The utility currently uses the [FastText](https://fasttext.cc/) library for classification.

## Prerequisites

You'll need Python 3. Configure a virtual env or whatever way of running you prefer.

Install requirements:

```bash
pip install -r requirements.txt
```

## Running the utility

Run the utility with Python:

```bash
python training-util.py
```

The default behaviour should perform all steps required: gathering data, assembling and cleaning it, then training
and testing a model.

### More options

To see the full list of available commands and steps, run
```bash
python training-util.py --help
```

Features include setting log level, working directory and starting/stopping the processing at particular steps.
This can be useful when e.g. experimenting with different training parameters while using the same training input.

## Using the output

Output is written to the working directory (default: `data`).

The model is stored as `model.ftz`, and may be used with the FastText library for making predictions.
Intermediary data is also stored, and can be re-used when "skipping" steps, e.g. to retrain model on same input:

```bash
python training-util.py --from-step=train
```
