import sys

class Game():
    def __init__(self, roulette, casino):
        self.gui = None
        self.roulette = roulette
        self.casino = casino
        self.players = list()
        self.bets = list()
        self.current_player = 0
        self.current_bet_value = 0
 
    def set_gui(self, gui):
        self.gui = gui
        
    def game_over(self, player_arr, casino):
        if casino.stakes == 0:
            return True

        for player in player_arr:
            if player.stakes == 0:
                return True
        
        return False

    def switch_to_player(self, player):
        self.current_player = player
        
    def spin_roulette(self):
        result = self.roulette.spin()
        if self.gui is not None:
            self.gui.roulette_view.spin(1000)
            self.gui.display.set_value(result)
        self.pay_bets(result)

    def close(self, window):
        sys.exit()

    def bet_add(self, bet):
        self.bets.append(bet)

    def pay_bets(self, result):
        for bet in self.bets:
            if bet.check_bet(result):
                self.players[bet.player].stakes += bet.payback * bet.price
                self.casino.stakes -= bet.payback * bet.price
            else:
                self.casino.stakes += bet.payback * bet.price
        self.gui.player_ui.update_left()
        self.gui.player_ui.update_right()
        self.bets = list()