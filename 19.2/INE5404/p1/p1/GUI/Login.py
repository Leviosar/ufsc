from tkinter import *
from PIL import Image, ImageTk
from pathlib import Path
from GUI.CustomButton import CustomButton
from GUI.CustomEntry import CustomEntry
from GUI.Colors import COLORS

class Login(Frame):
    def __init__(self, master, app, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.master = master
        self.app = app
        self.login_data = StringVar(value="Username")
        self.password_data = StringVar(value="********")
        self.create_fields()

    def create_fields(self):
        self.login = Entry(master=self, bg=COLORS['primary_grey'], fg="white", textvariable=self.login_data)
        self.login.pack()

        self.password = Entry(master=self, show="*", bg=COLORS['primary_grey'], fg="white", textvariable=self.password_data)
        self.password.pack()

        self.submit = Button(master=self, text="Sign in", bg=COLORS['primary_grey'], fg="white", command=lambda:self.try_login())
        self.submit.pack()

        self.signup = Button(master=self, text="Sign up", bg=COLORS['primary_grey'], fg="white", command=lambda:self.cad_user())
        self.signup.pack()

    def try_login(self):
        if self.app.master_controller.login_controller.auth_user(self.login_data.get(), self.password_data.get()):
            self.app.show_bookshelf()

    def cad_user(self):
        self.app.master_controller.login_controller.add_user(self.login_data.get(), self.password_data.get())