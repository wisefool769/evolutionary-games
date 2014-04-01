# When using geom_polygon, you will typically need two data frames:
# one contains the coordinates of each polygon (positions),  and the
# other the values associated with each polygon (values).  An id
# variable links the two together


library(ggplot2)
library(e1071)

train <- data.frame(read.csv("../../Results/Basanta/basanta_param-scan.csv", header=TRUE))
freq_names <- c('Type.1', 'Type.2', 'Type.3')
# plot.vars <- c('Beta', 'Delta', 'Coexistence')
plot.vars <- c('n', 'c', 'Coexistence')

#legend
#clusters 1, 2, 3, 12, 13, 23, 123

freqs.to.class <- function(freqs){
	f1 <- freqs$Type.1
	f2 <- freqs$Type.2
	f3 <- freqs$Type.3

	thresh <- 0.1

	if (f1 > thresh){
		if(f2 > thresh){
			if(f3 > thresh){
				return(123)
			} else {
				return(12)
			}
		} else if (f3 > thresh){
			return(13)
		} else {
			return(1)
		}
	}

	if(f2 > thresh){
		if(f3 > thresh){
			return(23)
		} else {
			return(2)
		}
	}

	return(3)
}

num.pts <- dim(train)[1]
coex.labels <- 
train$Coexistence <- 
	as.factor(sapply(
		1:num.pts,
		function (x) 
			freqs.to.class(train[x,freq_names])))


# svm.model <- svm(Coexistence ~ Beta + Delta, data = train)
svm.model <- svm(Coexistence ~ n + c, data = train)

setEPS()
postscript("basanta_phase-1.eps")
plot(svm.model, train[,plot.vars])
dev.off()

# ids <- factor(c("1.1", "2.1", "1.2", "2.2", "1.3", "2.3"))

# values <- data.frame(
#   id = ids,
#   value = c("yellow", "blue", "red")
# )

# positions <- data.frame(
#   id = rep(ids, each = 4),
#   x = c(2, 1, 1.1, 2.2, 1, 0, 0.3, 1.1, 2.2, 1.1, 1.2, 2.5, 1.1, 0.3,
#   0.5, 1.2, 2.5, 1.2, 1.3, 2.7, 1.2, 0.5, 0.6, 1.3),
#   y = c(-0.5, 0, 1, 0.5, 0, 0.5, 1.5, 1, 0.5, 1, 2.1, 1.7, 1, 1.5,
#   2.2, 2.1, 1.7, 2.1, 3.2, 2.8, 2.1, 2.2, 3.3, 3.2)
# )

# # Currently we need to manually merge the two together
# datapoly <- merge(values, positions, by=c("id"))
# p <- ggplot(datapoly, aes(x=x, y=y)) + geom_polygon(aes(fill=value, group=id))
# plot(p)