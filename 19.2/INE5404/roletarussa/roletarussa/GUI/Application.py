from tkinter import *
from PIL import Image, ImageTk
from GUI.Roulette import Roulette
from GUI.ResultDisplay import ResultDisplay
from GUI.Table import Table
from GUI.PlayerBar import PlayerBar
from GUI.PlayerUI import PlayerUI
from GUI.CustomButton import CustomButton
from pathlib import Path

class Application(Frame):
    def __init__(self, master=None, roulette=None, game_controller=None):
        super().__init__(master=master)
        self.master = master
        self.table_canvas = None
        self.player_canvas = None
        self.left_main = None
        self.right_main = None
        self.roulette_view = None
        self.player_view = None
        self.display = None
        self.game_controller = game_controller
        self.roulette_controller = roulette
        self.create_main()

    def create_main(self):
        self.create_backbone()
        self.create_roulette()
        self.create_table()

    def create_backbone(self):
        width = int(self.master.winfo_screenwidth())
        height = int(self.master.winfo_screenheight())
        self.left_main = Frame(self.master, bg="#303030", width=int(width/3), height=height)
        self.right_main = Frame(self.master, bg="#303030", width=int(width/3) * 2, height=height)
        self.left_main.grid(row=0, column=0)
        self.left_main.grid_propagate(0)
        self.right_main.grid(row=0, column=1)
        self.right_main.grid_propagate(0)
        
    def create_roulette(self):
        self.roulette_view = Roulette(master=self.master, main=self.left_main, app=self)
        self.display = ResultDisplay(master=self.master, main=self.left_main, app=self)
        self.spin_button = CustomButton(master=self.left_main, command=lambda:self.game_controller.spin_roulette(), text="SPIN")
        self.spin_button.grid(column=0, row=2)

    def create_table(self):
        self.table_view = Table(master=self.master, main=self.right_main, app=self)
        self.player_view = PlayerBar(master=self.master, main=self.right_main, app=self)
        self.player_ui = PlayerUI(master=self.master, main=self.right_main, app=self)