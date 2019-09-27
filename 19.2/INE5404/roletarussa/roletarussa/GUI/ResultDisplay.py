from tkinter import *
from GUI.Colors import COLORS

class ResultDisplay():
    def __init__(self, master, main, app):
        self.app = app
        self.master = master
        self.main = main
        self.display = None
        self.create_display()
        self.value = 0

    def create_display(self):
        self.display = Label(self.main, bg="#303030", fg="#fcba03", padx=40, pady=20, relief="solid", highlightbackground="#fcba03", highlightcolor="#fcba03", highlightthickness=3)
        self.display.grid(column=0, row=1)
    
    def set_value(self, result):
        self.value = result['number']
        self.display.config(bg=COLORS[result['color']])
        self.display.config(text=result['number'])

    def get_value(self):
        return self.value