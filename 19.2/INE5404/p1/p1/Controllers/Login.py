import json
from pathlib import Path
from Controllers.User import User

class Login:
    def __init__(self):
        self.users = list()
        self.fetch_users()

    def fetch_users(self):
        with open(Path('./Config/users.json'), 'r') as read_file:
            self.users_data = json.load(read_file)
        for user in self.users_data:
            print(user)
            self.users.append(User(user['username'], user['password']))

    def auth_user(self, login, password):
        for user in self.users:
            if user.login == login and user.password == password:
                return True
        return False

    def add_user(self, login, password):
        self.users.append(User(login, password))