from game import *
import csv
from nlattice import normalize

paramFile = open('tomlinson-pass2.csv', 'rU')
reader = csv.reader(paramFile)
params = [row for row in reader][1:] #read from this csv
params = map(lambda row: map(float, row), params) #convert strings to floats

dim = 50
depth = 3
maxAge = 1e8
cutoff = 0.15 * dim ** depth 

for i,param in enumerate(params):
	[a,b,c] = param
	print(param)
	payoff = [[a,b],[a,b]]
	g = Game(payoff, depth, dim, maxGen = maxAge, name = "tom-2_" + str(i), geom = "rect")
	print g.board.grid
	while not g.isFinished():
		if g.age % 5e5 == 0 and len(filter(lambda x: x < cutoff, g.count)) == 1:
			g.end()
			break

		g.update()


# for i in range(18):
# 	statFile = open("tom_" + str(i) +  "-stats.csv")
# 	reader = csv.reader(statFile)
# 	finalStats = map(float, [row for row in reader][-1])
# 	print finalStats







