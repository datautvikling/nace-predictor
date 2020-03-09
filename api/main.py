from flask import Flask, redirect

from app.api import API_BLUEPRINT

app = Flask(__name__)
app.register_blueprint(API_BLUEPRINT, url_prefix='/api')


@app.route("/")
def redirect_to_api():
    """Redirects root requests to the API documentation"""
    return redirect("api/")


if __name__ == '__main__':
    app.run(debug=True)
