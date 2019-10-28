from tkinter import *
from Entities.Player import Player
from GUI.CustomButton import CustomButton
from GUI.CustomLabel import CustomLabel

class PlayerUI():
    def __init__(self, master, main, app):
        self.app = app
        self.master = master
        self.main = main
        self.frame = None
        self.create_ui()

    def create_ui(self):
        width = self.main.winfo_width()
        height = self.main.winfo_height()
        self.frame = Frame(self.main, width=width, height=height/6, bg="#303030")
        self.frame.grid(column=0, row=1)
        self.frame.grid_propagate(0)
        
        self.right_container = Frame(self.frame, width=width/2, height=height/6, bg="#303030")
        self.right_container.grid(column=1, row=0)
        self.right_container.grid_propagate(0)
        
        self.left_container = Frame(self.frame, width=width/2, height=height/6, bg="#303030")
        self.left_container.grid(column=0, row=0)
        self.left_container.grid_propagate(0)

        self.create_left()
        self.create_right()

    def create_left(self):
        self.left_container.update_idletasks()
        width = self.left_container.winfo_width()
        height = self.left_container.winfo_height()
        self.name_label = CustomLabel(self.left_container, padx=20, pady=20, fg="white", bg="#303030", text=f"Name: {self.app.game_controller.players[self.app.game_controller.current_player].name}")
        self.name_label.grid(column=0, row=0, sticky="nsew")
        self.stakes_label = CustomLabel(self.left_container, padx=20, pady=20, fg="white", bg="#303030", text=f"Stakes: {self.app.game_controller.players[self.app.game_controller.current_player].stakes}")
        self.stakes_label.grid(column=0, row=1, sticky="nsew")
        
    def update_left(self):
        self.stakes_label.config(text=f"Stakes: {self.app.game_controller.players[self.app.game_controller.current_player].stakes}")
        self.name_label.config(text=f"Name: {self.app.game_controller.players[self.app.game_controller.current_player].name}")

    def create_right(self):
        self.right_container.update_idletasks()
        width = self.right_container.winfo_width()
        height = self.right_container.winfo_height()
        self.up_button = CustomButton(self.right_container, text="+", command=self.raise_bet, bg="#303030", fg="#ffffff", height=int(height/2), width=int(width/4))
        self.up_button.grid(column=0, row=0, sticky="nsew")
        self.down_button = CustomButton(self.right_container, text="-", command=self.lower_bet, bg="#303030", fg="#ffffff", height=int(height/2), width=int(width/4))
        self.down_button.grid(column=2, row=0, sticky="nsew")
        self.value_label = CustomLabel(self.right_container, text=self.app.game_controller.current_bet_value, bg="#202020", fg="#ffffff", width=int(width/4))
        self.value_label.grid(column=1, row=0, sticky="nsew")

    def update_right(self):
        self.value_label.config(text=self.app.game_controller.current_bet_value)

    def raise_bet(self):
        if self.app.game_controller.players[self.app.game_controller.current_player].stakes > self.app.game_controller.current_bet_value:
            self.app.game_controller.current_bet_value += 1
            self.update_right()

    def lower_bet(self):
        if self.app.game_controller.current_bet_value > 0 :
            self.app.game_controller.current_bet_value -= 1
            self.update_right()