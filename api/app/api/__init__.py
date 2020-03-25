from flask import Blueprint
from flask_restx import Api

from app.api.old_prediction import api as v0_api
from app.api.prediction import api as v1_api

API_BLUEPRINT = Blueprint('api', __name__)

API = Api(
    API_BLUEPRINT,
    title='NACE Prediction API',
    version='0.0.1',
    description='An API for predicting NACE codes. Use the v1 namespace, as v0 is deprecated.'
)

API.add_namespace(v0_api)
API.add_namespace(v1_api)
