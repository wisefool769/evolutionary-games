# first, read in training data and compute coexistence from phase_diag.r
train <- data.frame(read.csv("../../Results/b2/b2_param-scan.csv",header=TRUE))
train <- train[-22,]
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

train$Coexistence <- 
  as.factor(sapply(
    1:num.pts,
    function (x) 
      freqs.to.class(train[x,freq_names])))

train <- train[train$Coexistence == 123,]
#compute location of actual fixed point
numeric.vars <- c('n', 'c', 'k', 'Type.1', 'Type.2', 'Type.3', 'p.AG', 'p.INV', 'p.GLY')

rfp <- function(n, c, k){

  x1 <- (2 * n * k + k - n * c - k * c) / (2 * n ^ 2)
  x2 <- (n - k) / n
  x3 <- (k * c - k + c * n) / (2 * n ^ 2)
  return(c(x1,x2,x3))
}

calc.diff <- function(row){

  d1 <- as.numeric(row['Type.1']) - as.numeric(row['p.AG'])
  d2 <- as.numeric(row['Type.2']) - as.numeric(row['p.INV'])
  d3 <- as.numeric(row['Type.3']) - as.numeric(row['p.GLY'])
  return(c(d1,d2,d3))
}


params <- train[,c('n','c','k')]
real.fps <- t(apply(params, 1, function(x) rfp(x[1], x[2], x[3])))
colnames(real.fps) <- c('p.AG', 'p.INV', 'p.GLY')

train <- data.frame(cbind(as.matrix(train), real.fps))

diffs <- t(apply(train[,numeric.vars], 1, calc.diff))
colnames(diffs) <- c('d1', 'd2', 'd3')
#                                        
                                          