from tkinter import *
from PIL import Image, ImageTk
from GUI.Colors import COLORS
from pathlib import Path

class Roulette():
    def __init__(self, master, main, app):
        self.app = app
        self.master = master
        self.main = main
        self.canvas = None
        self.create_roulette()
        self.spinning = False

    def create_roulette(self):
        width = int(self.master.winfo_screenwidth())
        height = int(self.master.winfo_screenheight())
        self.canvas = Canvas(self.main, bd=0, highlightthickness=0, bg="#303030", width=int(width/3), height=int(width/3))
        self.canvas.grid(column=0, row=0)
        self.draw_canvas_roulette()
    
    def update_roulette(self):
        self.canvas.delete("all")
        self.app.roulette_controller.pieces.insert(0, self.app.roulette_controller.pieces[-1])
        del self.app.roulette_controller.pieces[-1]
        self.draw_canvas_roulette()
        if self.spinning:
            self.master.after(23, self.update_roulette)

    def spin(self, time):
        self.spinning = True
        self.master.after(23, self.update_roulette)
        self.master.after(time, self.stop_spin)

    def stop_spin(self):
        self.spinning = False

    def draw_canvas_roulette(self):
        self.master.update_idletasks()
        width = self.canvas.winfo_width()
        height = self.canvas.winfo_height()
        init = (width - 400) / 2
        end = width - ((width - 400) / 2)
        xy = init, init, end, end
        
        for index, piece in enumerate(self.app.roulette_controller.pieces):
            self.canvas.create_arc(xy, start=0 + (360/len(self.app.roulette_controller.pieces) * index), extent=360/len(self.app.roulette_controller.pieces), fill=COLORS[piece['color']])

        circle_init = (width / 2) - 150
        circle_end = width - ((width / 2) - 150)
        self.canvas.create_oval(circle_init, circle_init, circle_end, circle_end, fill="#303030")
        
        circle_init = (width / 2) - 130
        circle_end = width - ((width / 2) - 130)
        self.canvas.create_oval(circle_init, circle_init, circle_end, circle_end, fill=COLORS['golden'])
        
        circle_init = (width / 2) - 110
        circle_end = width - ((width / 2) - 110)
        self.canvas.create_oval(circle_init, circle_init, circle_end, circle_end, fill="#303030")