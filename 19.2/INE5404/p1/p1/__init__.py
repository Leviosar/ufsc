__version__ = '0.1.0'

from tkinter import *
from PIL import Image, ImageTk
from GUI.Application import Application
from Controllers.Master import Master

root = Tk()
root.geometry('400x600')
master_controller = Master()
app = Application(master=root, master_controller=master_controller)

root.mainloop()
