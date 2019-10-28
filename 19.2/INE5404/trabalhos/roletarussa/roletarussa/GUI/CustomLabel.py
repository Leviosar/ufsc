from tkinter import *
from GUI.Colors import COLORS

class CustomLabel(Label):
    def __init__(self, *args, **kwargs):
        Label.__init__(self, *args, **kwargs)
        invisibleImage = PhotoImage(width=1, height=1)
        self['image'] = invisibleImage
        self['compound'] = "c"
        self.image = invisibleImage