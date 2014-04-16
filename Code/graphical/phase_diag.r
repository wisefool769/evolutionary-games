library(ggplot2)
library(e1071)

study.name <- 'b2'

freq_names <- c('Type.1', 'Type.2', 'Type.3')

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

#name.format : c(1,2,3,12,13,23,123,cyclic)

if (study.name == 'basanta'){
  train <- data.frame(read.csv("../../Results/Basanta/basanta_param-scan.csv", header=TRUE))
  plot.vars <- c('n', 'c', 'Coexistence')
} else if(study.name == 'dingli'){
  train <- data.frame(read.csv("../../Results/Dingli/dingli_param-scan.csv", header=TRUE))
  plot.vars <- c('Beta', 'Delta', 'Coexistence')
} else if(study.name == 'tm2'){
  train <- data.frame(read.csv("../../Results/tm2/tm2_param-scan.csv", header=TRUE))
  plot.vars <- c('f', 'h', 'Coexistence')
} else if(study.name == 'b2'){  
  train <- data.frame(read.csv("../../Results/b2/b2_param-scan.csv",header=TRUE))
  plot.vars <- c('k', 'n', 'Coexistence')
  train <- train[-22,]
} else if(study.name == 'b3'){
  train <- data.frame(read.csv("../../Results/b3/b3_param-scan.csv",header=TRUE))
  plot.vars <- c('k', 'n', 'Coexistence')
}










num.pts <- dim(train)[1]

train$Coexistence <- 
	as.factor(sapply(
		1:num.pts,
		function (x) 
			freqs.to.class(train[x,freq_names])))



if (study.name == 'basanta'){
  
  train <- train[train$c <= 1 & train$n <= 1,]
  levels(train$Coexistence) <- c('AG','INV','GLY','A-I', 'A-G', 'Int')
  svm.model <- svm(Coexistence ~ n + c, data = train, kernel = "linear", cost = 10000)
  plot(svm.model, train[,plot.vars], 
       col = c("red", "yellow", "blue", "orange", "purple", "pink"), main = NULL
  )
} else if(study.name == 'dingli'){
  train <- train[train$Beta<=5 & train$Delta <= 5 & train$Coexistence != 123,]
  train$Coexistence <- droplevels(train$Coexistence)
  levels(train$Coexistence) <- c('OC-OB', 'OC-MM')
  svm.model <- svm(Coexistence ~ Beta + Delta, data = train, cost = 1000)
  plot(svm.model, train[,plot.vars])
} else if(study.name == 'tm2'){
  levels(train$Coexistence) <- c('P', 'R', 'P-R')
  svm.model <- svm(Coexistence ~ h + f, data = train, kernel = "linear", cost = 10000)
  plot(svm.model, train[,plot.vars], col = c("blue", "yellow", "green"))
} else if(study.name == 'b2'){
  train <- train[train$c <= 1 & train$n <= 1,]
  levels(train$Coexistence) <- c('AG','GLY','INV-GLY', 'Int')
  svm.model <- svm(Coexistence ~ k + n, data = train, kernel = "linear", cost = 10000)
  plot(svm.model, train[,plot.vars], col = c("yellow", "blue", "red", "green"))
} else if(study.name == 'b3'){
  svm.model <- svm(Coexistence ~ k + n, data = train, kernel = "linear", cost = 10000)
  plot(svm.model, train[,plot.vars])
}




