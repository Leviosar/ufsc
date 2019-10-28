import json

class Casino():
    def __init__(self):
        self.stakes = 1000
        self.name = "Casino"
    
    def modify_stakes(self, amount):
        self.stakes += amount
        
