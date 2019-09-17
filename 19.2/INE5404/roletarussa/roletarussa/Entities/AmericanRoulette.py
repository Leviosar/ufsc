from .Roulette import Roulette
import json

class AmericanRoulette(Roulette):

    def __init__(self):
        super().__init__()
        self.pieces = None
        self.mount_pieces()

    def mount_pieces(self):
        with open("./Config/american.json", "r") as read_file:
            self.pieces = json.load(read_file)['pieces']
