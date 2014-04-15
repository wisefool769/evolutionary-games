from game import *
import csv
from nlattice import normalize
from os import listdir
from aggregate import agg, get_last_row

result_dir = '../../Results/b3/'
study_name = 'b3'

dim = 75
depth = 3
max_age = 2 * 10 ** 7
cutoff_frac = 0.1
geom = "torus"
max_death = 2 #specific to game / parameter regime, most things we expect to coexist
cutoff = cutoff_frac * dim ** depth


with open(result_dir + study_name +'-settings.txt', 'w') as summary_file:
	summary_file.write("""
		dim: %d
		depth: %d 
		max_age: %.3g
		cutoff: %f
		geom: %s
		payoff: [[0,c/2,k-n],[1/2-c, 0, 1/2 + k - c], [n - k, c/2 - k, 0]]
		""" % (dim, depth, max_age, cutoff_frac, geom))


#format : n, c, k
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

	[n, c, k] = param

	#ask to skip, and if so, what last row to fill in with
	stat_fname = result_dir + study_name + '_' + str(i) + '-stats.csv'
	#ask to skip, and if so, what last row to fill in with
	# pause = raw_input("skip n = %.2f, c = %.2f, k = %.2f ? (prev index is %d) " 
	# 	% (n,c,k, i - 1))
	# if pause != "n":
	# 	with open(result_dir + study_name + '-skips.csv', 'a') as skipfile:
	# 		skipfile.write(",".join([str(i), pause]) + '\n')

		
	# 	prev_fname = result_dir + study_name + '_' + pause + '-stats.csv'
	# 	prev_row = ",".join(get_last_row(prev_fname)) + '\n'
	# 	with open(stat_fname, 'w') as stat_file:
	# 		stat_file.write(prev_row)
	# 	continue
	payoff = [[0,c/2,k-n],[1/2-c, 0, 1/2 + k - c], [n - k, c/2 - k, 0]]
	print("setting up board %d (n, c, k) = (%.2f, %.2f, %.2f)..." % (i, n, c, k))
	g = Game(
		payoff,
		depth,
		dim,
		maxGen = max_age,
		name = result_dir + study_name + '_' + str(i),
		geom = "torus")
	print("running sim ...")

	while not g.isFinished():
		if g.age % 5e5 == 0:
			print("gen: %d" % g.age)
			if len(filter(lambda x: x < cutoff, g.count)) == max_death: #two things close to dying
				g.end()
				break
		g.update()

	print("finished at: " + ",".join(get_last_row(stat_fname)))
agg(result_dir, study_name)





