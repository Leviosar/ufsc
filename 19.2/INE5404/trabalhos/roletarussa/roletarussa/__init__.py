from tkinter import *
from PIL import Image, ImageTk
from Entities.AmericanRoulette import AmericanRoulette
from Entities.EuropeanRoulette import EuropeanRoulette
from Entities.Game import Game
from Entities.Player import Player
from Entities.Casino import Casino
from GUI.Application import Application
import sys

roulette = None

if len(sys.argv) >= 2:
    if sys.argv[1] == '-e':
        roulette = EuropeanRoulette()
    else:
        roulette = AmericanRoulette()
else: 
    roulette = AmericanRoulette()

casino = Casino()
game = Game(roulette, casino)
root = Tk()
root.attributes('-fullscreen', True)
app = Application(master=root, roulette=roulette, game_controller=game)
game.set_gui(gui=app)
root.mainloop()