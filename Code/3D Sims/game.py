from lattice import *
from wraplattice import *


class Game():
	def __init__(self, payoff, dim, maxGen = False, name = "test", geom = "rect", freqs = False):
		self.dim = dim
		self.payoff = payoff
		self.name = name
		self.maxGen = maxGen
		
		ic = freqs if freqs else [1 for i in payoff]

		if (geom == "rect"):
			self.board = Lattice(dim, rand = True, freqs = ic)
		elif (geom == "sphere"):
			self.board = WrapLattice(dim, rand = True, freqs = ic)

		self.fits = Lattice(dim)
		self.calcFitness()
		self.count = self.board.count()
		self.statFile = open(name + "-stats.csv", "w")

		self.setupFile = open(name + "-params" + ".txt", "w")
		self.setupFile.write("\n".join(map(str, [payoff, dim, maxGen])))
		self.setupFile.close()
		
		self.age = 0

	def calcCellFitness(self, p):
		neighbors = self.board.neighborhood(p,1)
		tp = sum(
			self.payoff
			[self.board.access(p)]
			[self.board.access(i)] 
			for i in neighbors)
		return tp

	def calcFitness(self):
		for x in range(self.dim):
			for y in range(self.dim):
				for z in range(self.dim):
					p = [x,y,z]
					self.fits.set(p, self.calcCellFitness(p))

	def fitness(self, p):
		return self.fits.access(p)

	def update(self): #returns a list giving changed value and what it was changed to

		toReplace = self.board.randElement() #select random element
		currentValue = self.board.access(toReplace) #get value
		neighbors = self.board.neighborhood(toReplace,1) #get neighbors
		neighborFits = [self.fitness(i) for i in neighbors]
		replaceWith = neighbors[choose(neighborFits)]
		replaceValue = self.board.access(replaceWith) #choose neighbor based on fitness
		#print(p)
		if currentValue != replaceValue:
			newFit = 0
			for i in neighbors:
				neighborValue = self.board.access(i)
				fitInc = self.payoff[neighborValue][replaceValue] 
				- self.payoff[neighborValue][currentValue]
				self.fits.increment(i, fitInc)
				
				newFit += self.payoff[replaceValue][neighborValue]

			self.board.set(toReplace, replaceValue)
			self.fits.set(toReplace, newFit)
			
			self.count[currentValue] -= 1
			self.count[replaceValue] += 1
		self.age += 1
		return [toReplace, replaceValue]

	def stats(self):
		freq = normalize(self.count)
		st = [self.age] + freq
		self.outFile.write(",".join(map(str, st)))



#todo: stat-tracking