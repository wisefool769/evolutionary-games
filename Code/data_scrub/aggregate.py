import csv
from os import listdir
from collections import deque


def get_last_row(csv_filename):
    with open(csv_filename, 'rb') as f:
        return deque(csv.reader(f), 1)[0]

data_dir = "../../Results/Tomlinson Tab 1 ParamScan/"
param_fname = "tomlinson-params.csv"

stat_files = [f for f in listdir(data_dir) if f[-9:] == "stats.csv"]

param_file = open(data_dir + param_fname, 'rU')
param_data = map(str.strip, param_file.readlines())
param_header, param_rows = param_data[0], param_data[1:]

for i,f in enumerate(stat_files):
	full_name = data_dir + f
	num = int(f[4 : f.index("-")])
	end_freqs = ','.join(get_last_row(full_name)[1:])
	param_freqs.append(param_rows[i] + ',' + end_freqs)

header = param_header + ',Type 1,Type 2,Type 3 \n'
with open(data_dir + 'param-result.csv', 'w') as pf_file:
	pf_file.write(header)
	pf_file.write('\n'.join(param_freqs))


	




