from lattice import Lattice

class WrapLattice(Lattice):
	def wrap(self, p):
		for i,val in enumerate(p):
			if val < 0:
				p[i] += self.dim
			if val >= dim:
				p[i] -= self.dim
		return p

	def neighborhood(self, p, r):
		[x,y] = p
		n = []
		for rx in range(x-r, x + r+1):
			for ry in range(y - r, y + r+1):
				np = wrap([rx, ry])
				n.append(np)
		if self.inArray(p):
			n.remove(p)
		return n