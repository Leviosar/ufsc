from Controllers.Login import Login
from Controllers.User import User
from Controllers.Book import Book
from Controllers.Bookshelf import Bookshelf

class Master:
    def __init__(self):
        self.login_controller = Login()
        self.bookshelf_controller = Bookshelf()