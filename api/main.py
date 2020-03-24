import google.cloud.logging
from flask import Flask, redirect
from flask_cors import CORS

from app.api import API_BLUEPRINT

app = Flask(__name__)
app.register_blueprint(API_BLUEPRINT, url_prefix='/api')
CORS(app)


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
