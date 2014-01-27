from lattice import *
from wraplattice import *


class Game():
	def __init__(self, payoff, dim, maxGen = False, name = "test"):
		self.dim = dim
		self.payoff = payoff
		self.name = name
		self.maxGen = maxGen
		
		ic = [1 for i in payoff]
		self.board = Lattice(dim, rand = True, freqs = ic)
		self.fits = Lattice(dim)
		self.calcFitness()
		self.count = self.board.count()
		self.outFile = open(name + ".csv", "w")

		self.statFile = open(name + "-params" + ".txt", "w")
		self.statFile.write("\n".join(map(str, [payoff, dim, maxGen])))
		self.statFile.close()
		
		self.age = 0

	def calcFitness(self):
		for x in range(self.dim):
			for y in range(self.dim):
				for z in range(self.dim):
					p = [x,y,z]
					neighbors = self.board.neighborhood(p,1)
					tp = sum(
						self.payoff
						[self.board.access(p)]
						[self.board.access(i)] 
						for i in neighbors)
					self.fits.set(p, tp)

	def fitness(self, p):
		return self.fits.access(p)


	def update(self):
		r = self.board.randElement()
		rv = self.board.access(r)
		n = self.board.neighborhood(r,1)
		f = [self.fitness(i) for i in n]
		p = n[choose(f)]
		pv = self.board.access(p)
		#print(p)
		if pv != rv:
			for i in n:
				iv = self.board.access(i)
				fitInc = self.payoff[iv][pv] - self.payoff[iv][rv]
				self.fits.increment(i, fitInc)
			self.board.set(r, pv)
			self.count[rv] -= 1
			self.count[pv] += 1
		self.age += 1
		return [r, pv]

	def stats(self):
		freq = normalize(self.count)
		st = [gen] + freq + clust
		self.outFile.write(",".join(map(str, st)))

#todo: stat-tracking