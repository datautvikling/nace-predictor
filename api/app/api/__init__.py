from flask import Blueprint
from flask_restx import Api

from app.api.old_prediction import old_api

API_BLUEPRINT = Blueprint('api', __name__)

API = Api(
    API_BLUEPRINT,
    title='NACE Prediction API',
    version='0.0.1',
    description='An API for predicting NACE codes.'
)

API.add_namespace(old_api)
