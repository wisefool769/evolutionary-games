

# ### Plots functions for Toxin Game
# e <- 0.2
# g <- 0.4
# q <- ggplot(data.frame(x=c(0, 10)), aes(x)) +
#     stat_function(fun=function(x) e) +
#     xlim(0,1) +
#     ylim(0,1) +
#     stat_function(fun = function(x) x + e - g) +
#     stat_function(fun = function(x) x * e / g) +
#     theme(panel.grid.minor = element_blank(),
#           panel.grid.major = element_blank(),
#           panel.background = element_blank()) +
#     xlab('f') +
#     ylab('h')
# 
#     
# plot(q)


### Phase Diagram for Toxin Game
# ids <- factor(c("P", "P-R" , "Interior", "Cyclic"))
#               
# # ids <- factor(c("1.1", "2.1", "1.2", "2.2", "1.3", "2.3"))
# 
# values <- data.frame(
#   id = ids,
#   value = ids
# )

# rep.times <- c(5,3,3,4)
# poly.1.x <- c(0,0,1,1, g - e)
# poly.1.y <- c(0,1,1, 1 + e - g, 0)
# poly.2.x <- c(g, 1, 1)
# poly.2.y <- c(e, 1 + e - g, e/g)
# poly.3.x <- c(g, 1, 1)
# poly.3.y <- c(e, e/g, e)
# poly.4.x <- c(g - e, g, 1, 1)
# poly.4.y <- c(0,e,e,0)
#               
# positions <- data.frame(
#   id = rep(ids, rep.times),
#   x = c(poly.1.x, poly.2.x, poly.3.x, poly.4.x),
#   y = c(poly.1.y, poly.2.y, poly.3.y, poly.4.y)
# )
# 
# 
# # Currently we need to manually merge the two together
# datapoly <- merge(values, positions, by=c("id"))
# p <- ggplot(datapoly, aes(x=x, y=y)) +
#   geom_polygon(aes(fill=value, group=id)) + 
#   xlab('f') + 
#   ylab('h') + 
#   ggtitle('Toxin Mean-Field Phase Diagram') + 
#   scale_fill_discrete(name = "Equilibrium") + 
#   theme(panel.grid.major=element_blank(),
#     panel.grid.minor=element_blank(),
#     plot.background=element_blank(),
#     panel.background=element_blank(),
#     panel.border=element_blank()
#     )
# 
# plot(p)

# ## Plots functions for Basanta Game holding k constant
k <- 0.2

q <- ggplot(data.frame(x=c(0, 10)), aes(x)) +
    xlim(0,1) +
    ylim(0,1) +
    geom_vline(xintercept = 0.5, colour = "red") +
    stat_function(fun=function(x) k , colour = "green") +
     stat_function(fun = function(x) k * (1 - x) / x, colour = "blue") +
    stat_function(fun = function(x) k * (x - 1) / (2 * k - x), colour = "yellow") +
  stat_function(fun = function(x) k * (x - 1) / (2 * k - x), colour = "purple") +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_blank(),
          panel.background = element_blank()) +
    xlab('n') +
    ylab('c')

    
plot(q)


#Functions for Basanta holding c constant > 1/2
# c <- 0.6
# 
# q <- ggplot(data.frame(x=c(0, 10)), aes(x)) +
#     xlim(0,1) +
#     ylim(0,1) +
#       stat_function(fun = function(x) c/2, colour = "red") + 
#       stat_function(fun=function(x) x , colour = "green") +
# stat_function(fun = function(x) c * x / (1 - c + 2 * x), colour = "purple") +
#    stat_function(fun = function(x) c - 1/2) + 
#     theme(panel.grid.minor = element_blank(),
#           panel.grid.major = element_blank(),
#           panel.background = element_blank()) +
#     xlab('n') +
#     ylab('k')
# 
#   
# plot(q)

### Basanta Ribbons holding c constant > 1/2
# c <- 0.6
# f1 <- function(x){ #invadability of IG
#   return(c * x / (1 - c + 2 * x))
# }
# 
# f2 <- function(x){ # positivity of int. fixed point, useless here
#   return(c / (1- c) * x)
# }
# 
# f3 <- function(x){
#   return(x)
# }
# 
# 
# 
# 
# xvals = seq(0,1,0.001)
# crvs <- data.frame(x = xvals,
#                    y1 = f1(xvals),
#                    y3 = f3(xvals))
# 
# 
# 
# q <- ggplot(crvs, aes(x = x)) + 
#   xlim(0,1) + 
#   ylim(0,1) + 
#   xlab('n') + 
#   ylab('k') + 
#   geom_ribbon(aes(ymin = y3, ymax = 1, fill = 'AG')) + 
#   geom_ribbon(aes(ymin = ifelse(xvals > c/2, c/2, 0),
#                   ymax = ifelse(y3 > c/2, y3, 0),
#                   fill = 'Cyclic')) + 
#   geom_ribbon(aes(ymin = ifelse(xvals > c - 1/2, f1(xvals), 0),
#                   ymax = ifelse(xvals > c - 1/2, pmin(xvals, c/2), 0),
#                   fill = 'AG-INV-GLY')) + 
#   geom_ribbon(aes(ymin = ifelse(xvals > c - 1/2, c - 1/2, 0),
#                   ymax = ifelse(xvals > c - 1/2, f1(xvals), 0),
#                   fill = 'INV-GLY')) +
#  geom_ribbon(aes(ymin = 0, 
#                  ymax = pmin(y3, rep(c - 1/2, length(y3))), fill = "GLY") ) + 
#   
# #   geom_ribbon(aes(ymin = y2, ymax = 1, fill = 'AG-INV')) + 
#     scale_fill_discrete(name = "Equilibrium")+
#     theme(panel.grid.major=element_blank(),
#       panel.grid.minor=element_blank(),
#       plot.background=element_blank(),
#       panel.background=element_blank(),
#       panel.border=element_blank()
#       ) + 
#   ggtitle(paste('Glycolytic Mean-Field Phase Diagram for c =', toString(c)))
# plot(q)


### Basanta Ribbons holding c constant < 1/2
# c <- 0.4
# f1 <- function(x){
#   return(c * x / (1 - c + 2 * x))
# }
# 
# f2 <- function(x){
#   return(c / (1- c) * x)
# }
# 
# xvals = seq(0,1,0.01)
# crvs <- data.frame(x = xvals,
#                    y1 = f1(xvals),
#                    y2 = f2(xvals))
# 
# q <- ggplot(crvs, aes(x = x)) + 
#   xlim(0,1) + 
#   ylim(0,1) + 
#   xlab('n') + 
#   ylab('k') + 
#   geom_ribbon(aes(ymin = 0, ymax = y1, fill = 'INV-GLY')) + 
#   geom_ribbon(aes(ymin = y1, ymax = y2, fill = 'AG-INV-GLY')) + 
#   geom_ribbon(aes(ymin = y2, ymax = 1, fill = 'AG-INV')) + 
#     scale_fill_discrete(name = "Equilibrium")+
#     theme(panel.grid.major=element_blank(),
#       panel.grid.minor=element_blank(),
#       plot.background=element_blank(),
#       panel.background=element_blank(),
#       panel.border=element_blank()
#       ) + 
#   ggtitle(paste('Glycolytic Mean-Field Phase Diagram for c =', toString(c)))
# plot(q)

###Plot Ribbons for Basanta Game
# k <- 0.05
# f1 <- function(x){
#   return(k * (1 - x) / x)
# }
# 
# f2 <- function(x){
#   return(k * (x - 1) / (2 * k - x))
# }
# 
# step <- 0.001
# xvals <- seq(0,1,step)
# l <- 1/step + 1
# xr1 <- seq(0,0.5,step)
# l1 <- length(xr1)
# xr2 <- seq(0.5 + step,1,step)
# l2 <- length(xr2)
# 
# xr3 <- seq(0.5 + step, k + 0.5, step)
# l3 <- length(xr3)
# xr4 <- seq(k + 0.5 + step, 1, step)
# l4 <- length(xr4)
# 
# xr5 <- seq(0, k, step)
# l5 <- length(xr5)
# 
# xr6 <- seq(k + step, 0.5, step)
# l6 <- length(xr6)
# 
# h <- c(rep(k,l1), rep(0,l2))
# f11 <- c(f1(xr1), rep(0,l2))
# f12 <- c(rep(0,l1), f1(xr2))
# f22 <- c(rep(0,l1), f2(xr2))
# 
# 
# crvs <- data.frame(x = xvals, 
#                    y1.upper = h,
#                    y2.lower = c(rep(0,l5), f1(xr6), rep(0, l2)),
#                    y2.upper = c(rep(0,l5), rep(1, l6), rep(0,l2)), 
#                    y3.lower = c(rep(k,l5), rep(k,l6), rep(0,l2)),
#                    y3.upper = c(rep(1,l5), f1(xr6), rep(0,l2)),
#                    y4.upper = f12, 
#                    y5.lower = c(rep(0,l1), f1(xr3), f1(xr4)), 
#                    y5.upper = c(rep(0,l1), rep(k,l3), f2(xr4)), 
#                    y6.lower = c(rep(0,l1), rep(0,l3), f2(xr4)),
#                    y6.upper = c(rep(0,l1), rep(0,l3), rep(k,l4)), 
#                    y7.lower = c(rep(0,l1), rep(k,l3), rep(0,l4)),
#                    y7.upper = c(rep(0,l1), f2(xr3), rep(0,l4)),
#                    y8.lower = c(rep(0,l1), f2(xr3), rep(k,l4)),
#                    y8.upper = c(rep(0,l1), rep(1,l3), rep(1,l4))
# )
#                    
# 
# q <- ggplot(crvs, aes(x = x)) + 
#     xlim(0,1) + 
#     ylim(0,1) +
#     xlab("c") + 
#     ylab("n") + 
#     ggtitle(paste("Glycolytic Mean-Field Phase Diagram for k = ", toString(k))) + 
#     geom_ribbon(aes(ymin = 0, ymax = y1.upper, fill = "A")) + 
#     geom_ribbon(aes(ymin = y2.lower, ymax = y2.upper, fill = "B")) + 
#     geom_ribbon(aes(ymin = y3.lower, ymax = y3.upper, fill = "C")) + 
#     geom_ribbon(aes(ymin = 0, ymax = y4.upper, fill = "D")) +
#      geom_ribbon(aes(ymin = y5.lower, ymax = y5.upper, fill = "E")) +
#   geom_ribbon(aes(ymin = y6.lower, ymax = y6.upper, fill = "F")) + 
#   geom_ribbon(aes(ymin = y7.lower, ymax = y7.upper, fill = "G")) +
#   geom_ribbon(aes(ymin = y8.lower, ymax = y8.upper, fill = "H")) +
#   scale_fill_discrete(name = "Equilibrium")+
#   theme(panel.grid.major=element_blank(),
#     panel.grid.minor=element_blank(),
#     plot.background=element_blank(),
#     panel.background=element_blank(),
#     panel.border=element_blank()
#     )
# 
# 
# 
# 
# plot(q)




### Phase Diagram for Dingli Game

# ids <- factor(c("OC-OB", "Bistable" , "OC-MM"))
#               
# 
# 
# values <- data.frame(
#   id = ids,
#   value = ids
# )
# 
# 
# rep.times <- c(3,4,4)
# poly.1.x <- c(0,0,1)
# poly.1.y <- c(0,1,0)
# poly.2.x <- c(1,0,2,2)
# poly.2.y <- c(0,1,1,0)
# poly.3.x <- c(0,0,2,2)
# poly.3.y <- c(1,2,2,1)
# 
#           
# positions <- data.frame(
#   id = rep(ids, rep.times),
#   x = c(poly.1.x, poly.2.x, poly.3.x),
#   y = c(poly.1.y, poly.2.y, poly.3.y)
# )
# 
# 
# # Currently we need to manually merge the two together
# datapoly <- merge(values, positions, by=c("id"))
# p <- ggplot(datapoly, aes(x=x, y=y)) +
#   geom_polygon(aes(fill=value, group=id)) + 
#   xlab(expression(delta)) + 
#   ylab(expression(beta)) + 
#   ggtitle('Dingli Mean-Field Phase Diagram') + 
#   scale_fill_discrete(name = "Equilibrium") + 
#   theme(panel.grid.major=element_blank(),
#     panel.grid.minor=element_blank(),
#     plot.background=element_blank(),
#     panel.background=element_blank(),
#     panel.border=element_blank()
#     )
# 
# plot(p)


### Phase Diagram for Basanta Game

# ids <- factor(c("OC-OB", "Bistable" , "OC-MM"))
#               
# 
# 
# values <- data.frame(
#   id = ids,
#   value = ids
# )
# 
# 
# rep.times <- c(3,4,4)
# poly.1.x <- c(0,0,1)
# poly.1.y <- c(0,1,0)
# poly.2.x <- c(1,0,2,2)
# poly.2.y <- c(0,1,1,0)
# poly.3.x <- c(0,0,2,2)
# poly.3.y <- c(1,2,2,1)
# 
#           
# positions <- data.frame(
#   id = rep(ids, rep.times),
#   x = c(poly.1.x, poly.2.x, poly.3.x),
#   y = c(poly.1.y, poly.2.y, poly.3.y)
# )
# 
# 
# # Currently we need to manually merge the two together
# datapoly <- merge(values, positions, by=c("id"))
# p <- ggplot(datapoly, aes(x=x, y=y)) +
#   geom_polygon(aes(fill=value, group=id)) + 
#   xlab(expression(delta)) + 
#   ylab(expression(beta)) + 
#   ggtitle('Dingli Mean-Field Phase Diagram') + 
#   scale_fill_discrete(name = "Equilibrium") + 
#   theme(panel.grid.major=element_blank(),
#     panel.grid.minor=element_blank(),
#     plot.background=element_blank(),
#     panel.background=element_blank(),
#     panel.border=element_blank()
#     )
# 
# plot(p)


