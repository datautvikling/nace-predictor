from flask import Blueprint
from flask_restx import Api

from api.old_prediction import api as v0_api
from api.prediction import api as v1_api

API_BLUEPRINT = Blueprint('api', __name__)

API = Api(
    API_BLUEPRINT,
    title='NACE Prediction API',
    version='0.0.1',
    description='An API for predicting NACE codes.'
)

API.add_namespace(v0_api)
API.add_namespace(v1_api)
