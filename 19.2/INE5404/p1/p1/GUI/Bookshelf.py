from tkinter import *
from PIL import Image, ImageTk
from pathlib import Path
from GUI.CustomButton import CustomButton
from GUI.CustomEntry import CustomEntry
from GUI.Colors import COLORS

class Bookshelf(Frame):
    def __init__(self, master, app, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.master = master
        self.app = app
        self.scroll = Scrollbar(master=self.master)
        self.scroll.pack(side=RIGHT, fill=Y)
        self.listbox = Listbox(master=self.master, yscrollcommand=self.scroll.set, width=400, height=600)
        self.put_books()

    def put_books(self):
        self.listbox.pack()
        for book in self.app.master_controller.bookshelf_controller.books:
            self.listbox.insert(END, f'{book.title}, {book.author}, {book.isbn}')
        self.scroll.config(command=self.listbox.yview)