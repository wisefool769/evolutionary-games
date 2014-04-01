cart.to.tern <- function(coords){
	a <- coords[1]
	b <- coords[2]
	c <- coords[3]
	x <- 1 / 2 * (2 * b + c) / (a + b + c)
	y <- sqrt(3) / 2 * c / (a + b + c)
	return(c(x , y))
}

freq.names <- c('Type.1', 'Type.2', 'Type.3')


process.freqs <- function(fname){
	freq.data <- data.frame(read.csv(fname, header=FALSE))
	colnames(freq.data) <- c('Iteration', 'Type.1', 'Type.2', 'Type.3', 'Clustering')
	just.freqs <- as.matrix(freq.data[,freq.names])
	colnames(just.freqs) <- NULL
	sf <- apply(just.freqs, 1, cart.to.tern)
	simp.freqs <- data.frame(cbind(sf[1,], sf[2,]))
	colnames(simp.freqs) <- c('x', 'y')
	return(simp.freqs)
}

# dingli.fname.1 <- "../../Results/Dingli/dingli_19-stats.csv"
# dingli.fname.2 <- "../../Results/Dingli/dingli_27-stats.csv"
# dingli.fname.3 <- "../../Results/Dingli/dingli_33-stats.csv"
# dingli.fname.4 <- "../../Results/Dingli/dingli_5-stats.csv"

# d1 <- process.freqs(dingli.fname.1)
# d2 <- process.freqs(dingli.fname.2)
# d3 <- process.freqs(dingli.fname.3)
# d4 <- process.freqs(dingli.fname.4)
# d1234 <- melt(list(d1 = d1, d2 = d2, d3 = d3, d4 = d4), id.vars = "x")

# d1234$L1 <- as.factor(d1234$L1)


basanta.fname.1 <- "../../Results/Basanta/basanta_45-stats.csv" #1 wins
basanta.fname.2 <- "../../Results/Basanta/basanta_53-stats.csv" #coexistence
basanta.fname.3 <- "../../Results/Basanta/basanta_17-stats.csv" #2 wins
basanta.fname.4 <- "../../Results/Basanta/basanta_26-stats.csv" #3 wins
basanta.fname.5 <- "../../Results/Basanta/basanta_43-stats.csv" #1 and 2 coexist
b1 <- process.freqs(basanta.fname.1)
b2 <- process.freqs(basanta.fname.2)
b3 <- process.freqs(basanta.fname.3)
b4 <- process.freqs(basanta.fname.4)
b5 <- process.freqs(basanta.fname.5)
b <- melt(list(b1 = b1, b2 = b2, b3 = b3, b4 = b4,b5 = b5), id.vars = "x")

b$L1 <- as.factor(b$L1)




# num.points <- dim(simp.freqs)[1]
# simp.freqs$clr <- c("green", rep("black", num.points - 2), "red")


ids <- factor(c("1"))
positions <- data.frame(
	id = rep(ids,3), 
	x = c(0, 1, 0.5), 
	y = c(0, 0, sqrt(3)/2)
)



## dingli

# colnames(d1234) <- c('x', 'variable', 'y', 'L2')

# q <- ggplot(d1234, aes(x = x, y = y)) + 
# 	geom_point(shape = 19, size = 0.4, alpha = 0.75) +
# 	# #scale_colour_manual("", values = c("d1" = "blue", "d2" = "red")) 
# 	xlim(0,1) +
# 	ylim(0,1) +
# 	geom_polygon(data = positions, alpha = 0.2, fill = "orange") +
# 	theme(#axis.line = element_blank(), 
# 		  axis.text.x = element_blank(), 
# 		  axis.text.y = element_blank(), 
# 		  #axis.ticks = element_blank(), 
# 		  axis.title.x = element_blank(), 
# 		  axis.title.y = element_blank(),
# 		  legend.position="none",
# 	      panel.background=element_blank(),
# 	      panel.border=element_blank(),
# 	      #panel.grid.major=element_blank(),
# 	      #panel.grid.minor=element_blank(),
# 	      plot.background=element_blank()
# 	      )

## basanta
colnames(b) <- c('x', 'variable', 'y', 'L2')

q <- ggplot(b, aes(x = x, y = y)) + 
	geom_point(shape = 19, size = 0.2, alpha = 0.75) +
	# #scale_colour_manual("", values = c("d1" = "blue", "d2" = "red")) 
	xlim(0,1) +
	ylim(0,1) +
	geom_polygon(data = positions, alpha = 0.2, fill = "orange") +
	theme(#axis.line = element_blank(), 
		  axis.text.x = element_blank(), 
		  axis.text.y = element_blank(), 
		  #axis.ticks = element_blank(), 
		  axis.title.x = element_blank(), 
		  axis.title.y = element_blank(),
		  legend.position="none",
	      panel.background=element_blank(),
	      panel.border=element_blank(),
	      #panel.grid.major=element_blank(),
	      #panel.grid.minor=element_blank(),
	      plot.background=element_blank()
	      )




pdf("test_scatter.pdf", width = 4, height = 4)
plot(q)
dev.off()
