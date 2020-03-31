import json

_users = None


def is_authorized(username: str, password: str):
    return (username, password) in _get_users()


def _get_users():
    global _users

    if not _users:
        with open("config.json") as json_file:
            users_config = json.load(json_file)["auth"]["users"]
            _users = [(user["username"], user["password"]) for user in users_config]

    return _users
