from newgame import *

payoff = [[0,2,0],[0,0,2],[2,0,0]]
g = Game(payoff, 3, 3, maxGen= 10)
while not g.isFinished():
	g.update()
