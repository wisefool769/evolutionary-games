from game import *
import csv
from nlattice import normalize
# payoff = [[2,0,0],[0,2,0],[0,0,2]] # rps

# tom_z = 1 #arbitrary baseline fitness
# tom_e = 0 #cost of producing cytotoxin e > 0
# tom_f = 0 #disadvantage of being affected by cytotoxin 0 < f < z
# tom_g = 0 #advantage of poisoning another cell
# tom_h = 0 #cost of resisting cytotoxin


# paramFile = open('tomlinson-params.csv', 'rU')
# reader = csv.reader(paramFile)
# params = [row for row in reader][1:] #read from this csv
# params = map(lambda row: map(float, row), params) #convert strings to floats

# dim = 40
# depth = 3
# maxAge = 1e8
# cutoff = 0.03 * dim ** depth 

# for i,param in enumerate(params):
# 	[tom_e, tom_f, tom_g, tom_h] = param

# 	payoff =[
# 	[tom_z - tom_e - tom_f + tom_g, tom_z - tom_h, tom_z - tom_f],
# 	[tom_z - tom_e, tom_z - tom_h, tom_z],
# 	[tom_z - tom_e + tom_g, tom_z - tom_h, tom_z]
# 	]
# 	print(payoff)
# 	g = Game(payoff, depth, dim, maxGen = maxAge, name = "tom_" + str(i), geom = "sphere")
# 	while not g.isFinished():
# 		if g.age % 5e5 == 0 and len(filter(lambda x: x < cutoff, g.count)) == 2:
# 			g.end()
# 			break

# 		g.update()


for i in range(18):
	statFile = open("tom_" + str(i) +  "-stats.csv")
	reader = csv.reader(statFile)
	finalStats = map(float, [row for row in reader][-1])
	print finalStats







