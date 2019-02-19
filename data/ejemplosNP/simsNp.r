setwd("/home/eric/Desktop/mydocs/itam/clases/pc2/ejemplosNP")

d <- read.csv(file = "simsNp.csv")

head(d)

attach(d)
hh <- (p1/100)^2+(p2/100)^2+(p3/100)^2+(p4/100)^2+(p5/100)^2+(p6/100)^2+(p7/100)^2+(p8/100)^2+(p9/100)^2+(p10/100)^2+(p11/100)^2+(p12/100)^2+(p13/100)^2+(p14/100)^2+(p15/100)^2+(p16/100)^2+(p17/100)^2+(p18/100)^2+(p19/100)^2

n <- 1/hh

np <- 1+n*(hh-(p1/100)^2)/hh

d$hh <- hh
d$n <- n
d$np <- np
detach(d)

d$n

write.csv(d$n, file = "tmp.csv", row.names=FALSE)

attach(d)
plot(x = p1, y = n, axes = FALSE, xlab = "v(partido mayor)")
axis(1, at = seq(10, 100, 5))
axis(2, at = seq(0,20,5))
axis(2, at = 1)
abline(h = 1:20, col = "gray")

graph7 n np p1, xlabel(10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100) ylabel(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20) yline(1,2,5,10,15) connect(mm) b2("% del mayor partido (p1)") l1("valor del indice")

list p1 p2 p3 n np if p1==50
