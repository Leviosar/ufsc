class Bet():
    def __init__(self, bet_type, value, player, price, payback):
        self.type = bet_type
        self.value = value
        self.price = price
        self.payback = payback
        self.player = player

    def check_bet(self, result):

        if self.type == 'number':
            if result['number'] == self.value:
                return True
            else:
                return False

        if self.type == 'color':
            if result['color'] == self.value:
                return True
            else: 
                return False

        if self.type == 'oddeven':
            if int(result['number']) % 2 == 0:
                if self.value == 'even':
                    return True
            if int(result['number']) % 2 != 0:
                if self.value == 'odd':
                    return True
            return False
            

        if self.type == 'highlow':
            if int(result['number']) > 18 and self.value == 'high':
                return True
            if int(result['number']) < 19 and self.value == 'low':
                return True
            return False

        if self.type == 'line':
            if int(result['number']) % 3 == 0 and self.value == 'bottom':
                return True
            if int(result['number']) % 3 == 2 and self.value == 'mid':
                return True
            if int(result['number']) % 3 == 1 and self.value == 'top':
                return True
            return False

        return False