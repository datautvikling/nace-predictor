# NACE predictor

NACE predictor is a project for predicting NACE codes with machine learning techniques.

The initial work was based on the [Offentlig AI](https://github.com/offentlig-ai) project.

## Applications

The project consists of several applications. See their respective README files for details.

### api

Provides prediction services through a RESTful API. See [README.md](api/README.md).

### demo-client

A simple demo client that provides a GUI for the API. See [README.md](demo-client/README.md).

### training-util

A CLI utility for training models. See [README.md](training-util/README.md).

## Training and providing a model

The steps for training and providing a model through the API is:

- Run the training-util to gather and process source data, and produce a model binary.
- Provide the trained model binary when running the API

See the README files of the respective applications for details.
