# When using geom_polygon, you will typically need two data frames:
# one contains the coordinates of each polygon (positions),  and the
# other the values associated with each polygon (values).  An id
# variable links the two together


library(ggplot2)
library(e1071)

# myplotSVM <- e1071:::plot.svm
# environment(myplotSVM)  <- .GlobalEnv
# fix(myplotSVM)



train <- data.frame(read.csv("../../Results/Basanta/basanta_param-scan.csv", header=TRUE))
# train <- data.frame(read.csv("../../Results/Dingli/dingli_param-scan.csv", header=TRUE))
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




# train <- train[train$Beta<=5 & train$Delta <= 5,]
# svm.model <- svm(Coexistence ~ Beta + Delta, data = train, cost = 1000)

# postscript("../../Report/Diagrams/dingli_phase-1.eps")
# plot(svm.model, train[,plot.vars],)
# dev.off()

train <- train[train$c <= 1 & train$n <= 1,]
svm.model <- svm(Coexistence ~ n + c, data = train, kernel = "linear", cost = 10000)


postscript("../../Report/Diagrams/basanta_phase-1.eps")
plot(svm.model, train[,plot.vars], 
	col = c("red", "yellow", "blue", "orange", "purple", "pink"), main = NULL
	)
dev.off()




