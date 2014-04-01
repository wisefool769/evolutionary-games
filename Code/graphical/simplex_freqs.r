cart.to.tern <- function(coords){
	a <- coords[1]
	b <- coords[2]
	c <- coords[3]
	x <- 1 / 2 * (2 * b + c) / (a + b + c)
	y <- sqrt(3) / 2 * c / (a + b + c)
	return(c(x , y))
}

freq.data <- data.frame(read.csv("../../Results/Dingli/dingli_19-stats.csv", header=FALSE))
colnames(freq.data) <- c('Iteration', 'Type.1', 'Type.2', 'Type.3', 'Clustering')
freq.names <- c('Type.1', 'Type.2', 'Type.3')

just.freqs <- as.matrix(freq.data[,freq.names])
colnames(just.freqs) <- NULL
sf <- apply(just.freqs, 1, cart.to.tern)
simp.freqs <- data.frame(cbind(sf[1,], sf[2,]))
colnames(simp.freqs) <- c('x', 'y')
num.points <- dim(simp.freqs)[1]
simp.freqs$clr <- c("green", rep("black", num.points - 2), "red")


ids <- factor(c("1"))
positions <- data.frame(
	id = rep(ids,3), 
	x = c(0, 1, 0.5), 
	y = c(0, 0, sqrt(3)/2)
)


q <- ggplot(simp.freqs, aes(x = x, y = y)) + 
	geom_point(shape = 19, size = 0.4, alpha = 0.75) + 
	xlim(0,1) + 
	ylim(0,1) +
	geom_polygon(data = positions, alpha = 0.2, fill = "orange") + 
	theme(axis.line = element_blank(), 
		  axis.text.x = element_blank(), 
		  axis.text.y = element_blank(), 
		  axis.ticks = element_blank(), 
		  axis.title.x = element_blank(), 
		  axis.title.y = element_blank(),
		  legend.position="none",
	      panel.background=element_blank(),
	      panel.border=element_blank(),
	      panel.grid.major=element_blank(),
	      panel.grid.minor=element_blank(),
	      plot.background=element_blank())





pdf("test_scatter.pdf", width = 4, height = 4)
plot(q)
dev.off()
