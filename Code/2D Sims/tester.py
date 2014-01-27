from game2d import *

payoff = [[0,2,0],[0,0,2],[2,0,0]]
g = Game2D(payoff, 10, freqs = [1,1,1], maxGen = 10)
while not g.isFinished():
	g.update()




