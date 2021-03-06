from game import *
import csv
from nlattice import normalize
from os import listdir
from aggregate import agg, get_last_row

result_dir = '../../Results/Dingli/'
study_name = 'dingli'

dim = 75
depth = 3
max_age =  10 ** 7
cutoff_frac = 0.1
geom = "torus"
max_death = 1
cutoff = cutoff_frac * dim ** depth


with open(result_dir + study_name +'-settings.txt', 'w') as summary_file:
	summary_file.write("""
		dim: %d
		depth: %d 
		max_age: %.3g
		cutoff: %f
		geom: %s
		payoff: [[0,1,beta],[1, 0, -delta], [beta, 0, 0]]
		""" % (dim, depth, max_age, cutoff_frac, geom))


#format : beta, delta
param_file = open(result_dir + study_name + '-params.csv', 'rU')
reader = csv.reader(param_file)
params = [row for row in reader][1:] #read from this csv
params = map(lambda row: map(float, row), params) #convert strings to floats

result_files = [f for f in listdir(result_dir) if f[-9:] == 'stats.csv']
result_indices = \
map(
	lambda f: int(f[f.find('_') + 1 : f.find('-')]),
	 result_files)





for i,param in enumerate(params):
	if i in result_indices:
		continue

	[beta, delta] = param
	stat_fname = result_dir + study_name + '_' + str(i) + '-stats.csv'
	payoff = [[0,1,beta],[1, 0, -delta], [beta, 0, 0]]
	print("setting up board %d with (beta,delta) = (%.2f, %.2f) ..." % (i, beta, delta))
	g = Game(
		payoff,
		depth,
		dim,
		maxGen = max_age,
		name = result_dir + study_name + '_' + str(i),
		geom = "torus")
	print("running sim")

	while not g.isFinished():
		if g.age % 5e5 == 0:
			print("gen: %d" % g.age)
			if len(filter(lambda x: x < cutoff, g.count)) == max_death: #one thing close to dying
				g.end()
				break
		g.update()

	print('finished at: ' + ','.join(get_last_row(stat_fname)))
	
agg(result_dir, study_name)





