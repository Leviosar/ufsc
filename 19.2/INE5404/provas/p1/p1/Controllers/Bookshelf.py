from Controllers.Book import Book
from pathlib import Path
import csv

class Bookshelf:
    def __init__(self):
        self.books = list()
        self.fetch_books()

    def fetch_books(self):
        print(self)
        with open(Path('./Config/books.csv'), 'r') as read_file:
            reader = csv.DictReader(read_file)
            for row in reader:
                self.books.append(Book(row['title'], row['authors'], row['isbn13']))