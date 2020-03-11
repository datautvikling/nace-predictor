# NACE Predictor demo client

This is a simple web application that uses the NACE Predictor API to offer a prediction GUI.

## Prerequisites

The project is written in [Elm](https://elm-lang.org/), using [Create Elm App](https://github.com/halfzebra/create-elm-app).

Install Elm according to [the instructions](https://guide.elm-lang.org/install/elm.html), and `Create Elm App`
according to the instructions in the previous link.

## Running the application

To start the application, run

```bash
elm-app start
``` 


## Deploying the application 

Files are included to host the application in [GCP App Engine](https://cloud.google.com/appengine/docs/standard/python/getting-started/hosting-a-static-website).

To deploy the application, first build it with

```bash
elm-app build
``` 

then deploy the built application with

```bash
gcloud app deploy
```

Note that the [GCloud SDK](https://cloud.google.com/sdk) must be installed and authenticated against the GCP project you are deploying to.
