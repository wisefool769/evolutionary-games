import csv
from os import listdir
from collections import deque


def agg(data_dir, study_name):
	def get_last_row(csv_filename):
	    with open(csv_filename, 'rb') as f:
	        return deque(csv.reader(f), 1)[0]

	param_fname = study_name + '-params.csv'

	stat_files = [f for f in listdir(data_dir) if f[-9:] == "stats.csv"]

	param_file = open(data_dir + param_fname, 'rU')
	param_data = map(str.strip, param_file.readlines())
	param_header, param_rows = param_data[0], param_data[1:]

	param_freqs = []

	for i,f in enumerate(stat_files):
		full_name = data_dir + f
		num = int(f[f.index("_") + 1 : f.index("-")])
		print(num)
		end_freqs = ','.join(get_last_row(full_name)[1:])
		param_freqs.append(param_rows[i] + ',' + end_freqs)

	header = param_header + ',Type 1,Type 2,Type 3,Clustering\n'
	with open(data_dir + 'dingli_param-scan.csv', 'w') as pf_file:
		pf_file.write(header)
		pf_file.write('\n'.join(param_freqs))


	




