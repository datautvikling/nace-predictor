# NACE predictor API

An API that provides prediction services for NACE codes based on a provided ML model.

## Prerequisites

You'll need Python 3. Configure a virtual env or whatever way of running you prefer.

Install requirements:

```bash
pip install -r requirements.txt
```

## Application configuration

The app is configured through the `config.json` file.

While a `config.json` file is provided in the code, this should be considered a default.
A custom configuration is expected to be provided on deployment 

### Configuration elements

#### Model

Information about the underlying ML model the API should use. It contains model metadata
such as the name of the model, and where the binary is located.

## Running the application

### Locally

To start the application, run `main.py`.

```bash
python main.py
```

By default, the application provides the API (with documentation) at http://localhost:5000.

### As a GCP App Engine service

The `app.yaml` file and naming the Flask variable in `main.py` `app` prepares the application
for deployment on [Google Cloud Platform App Engine Standard](https://cloud.google.com/appengine/docs/standard/python3/runtime).

To deploy the application, run 

```bash
gcloud app deploy
```

Note that the [GCloud SDK](https://cloud.google.com/sdk) must be installed and authenticated against the GCP project you are deploying to.

### As anything else

The application is a "plain" Flask Python app, and should be simple to package for 
use in other services (such as Kubernetes). 

Files for App engine deployment (`app.yaml`, .`gcloudignore`) can be ignored safely.

## Testing

Unit tests are found in [tests](), where the folder structure matches that of the main application.

For convenience (and CI/CD use), a script to discover and run all tests is included. 
To execute it, run

```bash
python quality_check.py
```
