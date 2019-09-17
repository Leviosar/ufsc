from Entities.AmericanRoulette import AmericanRoulette
import sys, pygame
pygame.init()
size = width, height = 320, 240
speed = [2, 2]
black = 0, 0, 0

screen = pygame.display.set_mode(size)
roulette = AmericanRoulette()
ball = pygame.image.load("./Assets/intro_ball.gif")
ballrect = ball.get_rect()

while  True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT: sys.exit()
    screen.fill(0, 0, 0)
    screen.blit(ball, ballrect)
    pygame.display.flip()