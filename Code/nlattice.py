from random import uniform, randint
from collections import Counter
from numpy import *
import itertools

def normalize(v): 	#normalize vector
	m = min(v)
	if (m < 0) or (sum(v) <= 0):
		v = [i - min(v) + 1 for i in v]
	s = sum(v)
	return [i/float(s) for i in v]

def choose(v):		#choose an item given vector of probabilities
	v = normalize(v)
	r = uniform(0,1)
	for i,val in enumerate(v):
		if val > r:
			return i
		else: 
			r -= val
	return (len(v) - 1)

def narray(func, d, dim):
	if d == 1:
		return map(func, [i for i in range(dim)])
	return [narray(func, d - 1, dim) for i in range(dim)]

def tupsum(t1, t2):
	return tuple(t1[i] + t2[i] for i in range(len(t1)))

class NLattice:

	def __init__(self, d, dim, interDist,
	 freqs = [0.333, 0.333, 0.333], rand = True, grid = 0):
		#print(freqs)
		self.d = d
		if rand:
			self.grid = array(narray(lambda x : choose(freqs), d, dim))
			self.numTypes = len(freqs)
			self.dim = dim
		else: 
			self.grid = array(grid)
			self.dim = dim
			self.numTypes = 0

		dists = [i for i in range(-1 * interDist, interDist + 1)] #possible distances -r to r
		self.offsets = [i for i in itertools.product(dists, repeat = self.d)]
		# all possible combinations of dists in n-d

	def access(self,p):
		return self.grid.item(p)
		

	def set(self,p,val):
		if self.inArray(p):
			self.grid.itemset(p, val)


	def increment(self, p, inc):
		if self.inArray(p):
			self.set(p, self.access(p) + inc)

	def inArray(self, p):
		if len(p) != self.d:
			return False
		for c in p:
			if c < 0 or c >= self.dim:
				return False
		return True

	def count(self):
		freqs = [0 for i in range(self.numTypes)]
		for i in self.grid.flat:
			freqs[i] += 1
		return freqs

	def randElement(self):
		return tuple(randint(0,self.dim - 1) for i in range(self.d))

	def neighborhood(self,p):
		return filter(self.inArray, 
			map(lambda x: tupsum(p, x), self.offsets))









