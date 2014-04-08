

### Plots functions for Toxin Game
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
# 

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


