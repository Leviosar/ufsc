class Player():
    def __init__(self):
        self.stakes = 100
        self.passed = 0
    
    def bet(self, amount):
        return amount
    
    def can_pass(self):
        if self.passed <= 3:
            return true
        else
            return false
    
    def modify_stakes(self, amount):
        this.stakes += amount
        
