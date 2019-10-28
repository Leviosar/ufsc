import json

class Player():
    def __init__(self, name):
        self.stakes = 100
        self.name = name
        self.passed = 0
    
    def can_pass(self):
        if self.passed <= 3:
            return True
        else:
            return False
    
    def modify_stakes(self, amount):
        self.stakes += amount
        
