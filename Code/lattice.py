from random import uniform, randint
from collections import Counter

def normalize(v): 	#normalize vector
	m = min(v)
	if (m < 0):
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



class Lattice:
	def access(self,p):
		if self.inArray(p):
			return self.grid[p[2]][p[1]][p[0]]
		return False

	def set(self,p,val):
		if self.inArray(p):
			self.grid[p[2]][p[1]][p[0]] = val

	def increment(self, p, inc):
		if self.inArray(p):
			self.grid[p[2]][p[1]][p[0]] += inc

	def __init__(self, dim, 
	 freqs = [0.333, 0.333, 0.333], rand = True, grid = 0):
		if rand:
			self.grid = [[[choose(freqs) for i in range(dim)] for j in range(dim)] for k in range(dim)]
			print(self.grid)
			self.numTypes = len(freqs)
			self.dim = dim
		else: 
			self.grid = grid
			self.dim = dim
			self.numTypes = 0
		self.freqs = self.count()

	def inArray(self, p):
		for c in p:
			if c < 0 or c >= self.dim:
				return False
		return True

	def count(self):
		freqs = [0 for i in range(self.numTypes)]
		#print(self.numTypes)
		for x in range(self.dim):
			for y in range(self.dim):
				for z in range(self.dim):
					freqs[self.access([x,y,z])] += 1
		return freqs

	def randElement(self):
		return [randint(0,self.dim) for i in range(3)]

	def neighborhood(self,p,r):
		x = p[0]
		y = p[1]
		z = p[2]
		n = []
		for rx in range(x-r, x + r+1):
			for ry in range(y - r, y + r+1):
				for rz in range(z -r, z + r+1):
					np = [rx, ry, rz]
					if self.inArray(np):
						n.append(np)
		if self.inArray(p):
			n.remove(p)
		return n




