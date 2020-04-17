import google.cloud.logging
from flask import Flask, redirect
from flask_cors import CORS

from app.api import API_BLUEPRINT
from app.infrastructure.model_provider import get_predictor

app = Flask(__name__)
app.register_blueprint(API_BLUEPRINT, url_prefix='/api')
CORS(app)


@app.route("/_ah/warmup")
def warmup():
    """Warms up the application"""
    # Getting a predictor means the underlying model is loaded.
    # This is expected to be the most costly "startup-action", so
    # when it is completed an instance should be sufficiently warmed up
    get_predictor()
    return "Warmed up!", 200


@app.route("/")
def redirect_to_api():
    """Redirects root requests to the API documentation"""
    return redirect("api/")


if __name__ == '__main__':
    app.run(debug=True)
else:
    # Assume we're running in GCP, configure logging.
    # For other environments, this code should be removed.
    client = google.cloud.logging.Client()
    client.setup_logging()
