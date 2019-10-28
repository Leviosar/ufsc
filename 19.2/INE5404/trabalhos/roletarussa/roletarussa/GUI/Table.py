import json
from tkinter import *
from pprint import pprint
from pathlib import Path
from GUI.Colors import COLORS
from GUI.CustomButton import CustomButton
from Entities.Bet import Bet

class Table:
    def __init__(self, master, main, app):
        self.app = app
        self.master = master
        self.main = main
        self.frame = None
        self.buttons = list()
        self.create_table()
        self.create_buttons()

    def create_table(self):
        self.main.update_idletasks()
        width = self.main.winfo_width()
        height = self.main.winfo_height()
        self.frame = Frame(self.main, width=width - 50, height=height/2, bg="#303030")
        self.frame.grid(column=0, row=0)
        self.frame.grid_propagate(0)

    def create_buttons(self):
        self.create_zero_button()
        self.create_numbers()
        self.create_extras()
    
    def create_numbers(self): 
        with open(Path("./Config/roulette_numbers.json"), "r") as read_file:
            pieces = json.load(read_file)

        for i in range(10):
            Grid.rowconfigure(self.frame, i, weight=1)
        
        for i in range(15):
            Grid.columnconfigure(self.frame, i, weight=1)
        
        for i, piece in enumerate(pieces["pieces"]):
            self.frame.update_idletasks()
            width = self.frame.winfo_width()
            height = self.frame.winfo_height()
            but = CustomButton(master=self.frame, fg="white", text=str(i+1), command=lambda piece=piece:self.make_bet(piece), bg=piece['color'], borderwidth=0, highlightthickness=2, highlightcolor=COLORS['golden'])
            but.grid(column=(1 + (i // 3)), row=1 + (i % 3), sticky=NSEW)
            self.buttons.append(but)

    def create_zero_button(self):
        self.frame.update_idletasks()
        width = self.frame.winfo_width()
        height = self.frame.winfo_height()

        but = CustomButton(master=self.frame, fg="white", text="0", command=lambda piece="zero":self.make_bet(piece), bg="#303030")
        but.grid(rowspan=3, column=0, row=1, sticky=NSEW)
        self.buttons.append(but)

    def create_extras(self):
        self.frame.update_idletasks()
        width = self.frame.winfo_width()
        height = self.frame.winfo_height()
        
        odd = CustomButton(master=self.frame, fg="white", text="Odd", bg="#303030", command=lambda oddeven="odd", bet_type="oddeven":self.make_bet(oddeven=oddeven, bet_type=bet_type))
        odd.grid(columnspan=4, column=1, row=0, sticky=NSEW)
        self.buttons.append(odd)
        
        even = CustomButton(master=self.frame, fg="white", text="Even", bg="#303030", command=lambda oddeven="even", bet_type="oddeven":self.make_bet(oddeven=oddeven, bet_type=bet_type))
        even.grid(columnspan=4, column=1, row=4, sticky=NSEW)
        self.buttons.append(even)

        red = CustomButton(master=self.frame, fg="white", text="Red", bg="#303030", command= lambda color="red", bet_type="color":self.make_bet(color=color, bet_type=bet_type))
        red.grid(columnspan=4, column=5, row=0, sticky=NSEW)
        self.buttons.append(red)
        
        black = CustomButton(master=self.frame, fg="white", text="Black", bg="#303030", command= lambda color="black", bet_type="color":self.make_bet(color=color, bet_type=bet_type))
        black.grid(columnspan=4, column=5, row=4, sticky=NSEW)
        self.buttons.append(black)

        low = CustomButton(master=self.frame, fg="white", text="Low", bg="#303030", command= lambda highlow="low", bet_type="highlow":self.make_bet(highlow=highlow, bet_type=bet_type))
        low.grid(columnspan=4, column=9, row=4, sticky=NSEW)
        self.buttons.append(low)

        high = CustomButton(master=self.frame, fg="white", text="High", bg="#303030", command= lambda highlow="high", bet_type="highlow":self.make_bet(highlow=highlow, bet_type=bet_type))
        high.grid(columnspan=4, column=9, row=0, sticky=NSEW)
        self.buttons.append(high)
        
        top_line = CustomButton(master=self.frame, fg="white", text="TL", bg="#303030", command= lambda line="top", bet_type="line":self.make_bet(line=line, bet_type=bet_type))
        top_line.grid(column=14, row=1, sticky=NSEW)
        self.buttons.append(top_line)

        mid_line = CustomButton(master=self.frame, fg="white", text="ML", bg="#303030", command= lambda line="mid", bet_type="line":self.make_bet(line=line, bet_type=bet_type))
        mid_line.grid(column=14, row=2, sticky=NSEW)
        self.buttons.append(mid_line)

        bot_line = CustomButton(master=self.frame, fg="white", text="BL", bg="#303030", command= lambda line="bot", bet_type="line":self.make_bet(line=line, bet_type=bet_type))
        bot_line.grid(column=14, row=3, sticky=NSEW)
        self.buttons.append(bot_line)
        
    def make_bet(self, piece=None, bet_type=None, line=None, highlow=None, color=None, oddeven=None):
        if self.app.game_controller.players[self.app.game_controller.current_player].stakes >= self.app.game_controller.current_bet_value:
            if bet_type is None:
                bet_type = 'number'
                value = piece['number']
                payback = 35
            
            if bet_type == 'line':
                value = line
                payback = 3

            if bet_type == 'highlow':
                value = highlow
                payback = 2

            if bet_type == 'oddeven':
                value = oddeven
                payback = 2

            if bet_type == 'color':
                value = color
                payback = 2

            new_bet = Bet(bet_type, value, self.app.game_controller.current_player, self.app.game_controller.current_bet_value, payback)
            self.app.game_controller.bet_add(new_bet)
            self.app.game_controller.players[self.app.game_controller.current_player].stakes -= self.app.game_controller.current_bet_value
            self.app.player_ui.update_left()
            self.app.player_ui.update_right()