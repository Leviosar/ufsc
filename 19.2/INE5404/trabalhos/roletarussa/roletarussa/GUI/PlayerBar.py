from tkinter import *
from Entities.Player import Player

class PlayerBar():
    def __init__(self, master, main, app):
        self.app = app
        self.master = master
        self.main = main
        self.frame = None
        self.player_buttons = list()
        self.create_bar()
        self.create_player()

    def create_bar(self):
        width = self.main.winfo_width()
        height = self.main.winfo_height()
        self.frame = Frame(self.main, width=width, height=height/6, bg="#303030")
        self.frame.grid(column=0, row=2)
        self.frame.grid_propagate(0)
        self.create_add_button()

    def create_add_button(self):
        but = Button(self.frame, text="Add player", bg="#303030", fg="#ffffff", command=self.create_player)
        but.grid(column=0, row=0)

    def create_player(self):
        player_number = len(self.app.game_controller.players)
        player = Player(name=f"Player {player_number + 1}")
        self.app.game_controller.players.append(player)
        player_button = Button(self.frame, text=player.name, bg="#303030", fg="#ffffff", command=lambda player_number=player_number:self.switch_player(player_number))
        self.player_buttons.append(player_button)
        player_button.grid(column=player_number + 2, row=0)

    def switch_player(self, player):
        self.app.game_controller.switch_to_player(player)
        self.app.player_ui.update_left()