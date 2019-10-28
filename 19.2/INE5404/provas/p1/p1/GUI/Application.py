from tkinter import *
from PIL import Image, ImageTk
from pathlib import Path
from GUI.Login import Login
from GUI.Bookshelf import Bookshelf
from GUI.Colors import COLORS

class Application(Frame):
    def __init__(self, master=None, master_controller=None):
        super().__init__(master=master)
        self.master.update_idletasks()
        self.master = master
        self.master_controller = master_controller
        self.create_backbone()
        self.create_login()

    def create_login(self):
        self.login_screen = Login(master=self.main_screen, app=self, bg=COLORS['primary_grey'], width=400, height=600)
        self.login_screen.pack()
        self.login_screen.pack_propagate(0)

    def create_backbone(self):
        self.main_screen = Frame(self.master, bg=COLORS['primary_grey'])
        self.main_screen.pack()

    def show_bookshelf(self):
        self.login_screen.destroy()
        self.bookshelf_screnn = Bookshelf(master=self.main_screen, app=self, bg=COLORS['primary_grey'], width=400, height=600)