from nlattice import *

class Game():
	def __init__(self, payoff, dim, d, maxGen = False,
	 name = "test", geom = "rect", freqs = False):
		self.dim = dim
		self.d = d
		self.payoff = payoff
		self.name = name
		self.maxGen = maxGen
		self.geom = geom

		ic = freqs if freqs else [1 for i in payoff]

		if (geom == "rect"):
			self.board = NLattice(d, dim, rand = True, freqs = ic)
		elif (geom == "sphere"):
			self.board = NWrapLattice(d, dim, rand = True, freqs = ic)

		self.fits = NLattice(d, dim)
		self.calcFitness()
		self.count = self.board.count()
		self.statFile = open(name + "-stats.csv", "w")

		self.setupFile = open(name + "-params" + ".txt", "w")
		self.setupFile.write("\n".join(map(str, [payoff, dim, maxGen])))
		self.setupFile.close()
		
		self.age = 0

	def calcCellFitness(self, p):
		neighbors = self.board.neighborhood(p)
		tp = sum(
			self.payoff
			[self.board.access(p)]
			[self.board.access(i)] 
			for i in neighbors)
		return tp

	def calcFitness(self):
		for (point,value) in self.board.iter():
			self.fits.set(point, self.calcCellFitness(point))

	def fitness(self, p):
		return self.fits.access(p)


	def isFinished(self):
		if self.maxGen and self.age > self.maxGen:
			self.end()
			return True
		return False

	def update(self): #returns a list giving changed value and what it was changed to	
		toReplace = self.board.randElement() #select random element
		currentValue = self.board.access(toReplace) #get value
		neighbors = self.board.neighborhood(toReplace) #get neighbors
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

		self.stats()
		return [toReplace, replaceValue]

	def stats(self):
		freq = normalize(self.count)
		st = ",".join(map(str,[self.age] + freq))
		self.statFile.write(st + "\n")

	def end(self):
		self.statFile.close()

