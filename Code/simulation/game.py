from nlattice import *

class Game():
	def __init__(self, payoff, d, dim, maxGen = False,
	 name = "test", geom = "rect", freqs = False):
		self.dim = dim
		self.d = d
		self.payoff = payoff
		self.name = name
		self.maxGen = maxGen
		self.geom = geom

		ic = freqs if freqs else [1 for i in payoff]

		if (geom == "rectangle"):
			self.board = NLattice(d, dim, rand = True, freqs = ic)
		elif (geom == "torus"):
			self.board = NWrapLattice(d, dim, rand = True, freqs = ic)

		self.fits = NLattice(d, dim)
		self.calcFitness()
		self.count = self.board.count()
		self.statFile = open(name + "-stats.csv", "w")
		
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
		if (self.maxGen and self.age > self.maxGen): 
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
		if currentValue != replaceValue: #then nothing changes
			newFit = 0
			for i in neighbors:
				neighborValue = self.board.access(i)
				fitInc = self.payoff[neighborValue][replaceValue] 
				- self.payoff[neighborValue][currentValue]  #update all neighbors 
				self.fits.increment(i, fitInc) #based on difference in payoff entries for old and new value
				
				newFit += self.payoff[replaceValue][neighborValue] #tally up fitness of new guy

			self.board.set(toReplace, replaceValue)
			self.fits.set(toReplace, newFit)
			
			self.count[currentValue] -= 1
			self.count[replaceValue] += 1
		self.age += 1 #update which generation we're on

		if self.age % 1000 == 0:
			self.stats()
			if self.age % 100000 == 0:
				self.statFile.flush()
		return [toReplace, replaceValue] #for debugging

	def numAlive(self):
		return reduce(lambda rest, x: rest + 1 if x != 0 else rest, self.count , 0)

	def stats(self):
		freq = normalize(self.count)
		cl = [self.board.cluster()]
		st = ",".join(map(str,[self.age] + freq + cl))
		#print(st)
		self.statFile.write(st + "\n")




	def end(self):
		self.statFile.close()

