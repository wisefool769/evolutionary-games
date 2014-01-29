from game import *

payoff = [[2,0,0],[0,2,0],[0,0,2]] # rps
dim = 0
d = 3
maxAge = 1e8
reachedMax = False

outFile = open("dim-search.csv", "w")

while not reachedMax:
	dim += 10
	g = Game(payoff, d, dim, maxGen = maxAge, name = "rps_" + str(dim))
	while not g.isFinished():
		if g.numAlive() < 3:
			g.end()
			break
		g.update()
	if g.age > g.maxGen:
		reachedMax = True
	print(dim)
	outFile.write(",".join(map(str, [dim, g.age])) + "\n")
	outFile.flush()





