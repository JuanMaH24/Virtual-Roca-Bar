from werkzeug.security import check_password_hash, generate_password_hash
from flask_login import UserMixin

class User(UserMixin):
    def __init__(self, user_id, user_name, password, name = "", lastname = "",rol = ""):
        self.user_id = user_id
        self.name  = name
        self.lastname = lastname 
        self.user_name = user_name
        self.password = password
        self.rol = rol

    @classmethod
    def check_password(self, hashed_password, password):
        return check_password_hash(hashed_password, password)
    
    def get_id(self):
           return (self.user_id)
    
# print(str(generate_password_hash("elixir900")))