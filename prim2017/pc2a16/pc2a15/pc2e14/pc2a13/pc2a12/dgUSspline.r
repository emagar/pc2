require("stats")

yrs <- c("1933-34", "1935-36", "1937-38", "1939-40", "1941-42", "1943-44", "1945-46", "1947-48",
    "1949-50", "1951-52", "1953-54", "1955-56", "1957-58", "1959-60", "1961-62", "1963-64", "1965-66", "1967-68",
    "1969-70", "1971-72", "1973-74", "1975-76", "1977-78", "1979-80", "1981-82", "1983-84", "1985-86", "1987-88",
    "1989-90", "1991-92", "1993-94", "1995-96", "1997-98", "1999-00", "2001-02", "2003-04", "2005-06", "2007-08",
    "2009-10")

time <- 1:length(yrs)

ddg <- c(0,0,0,0,0,0,0,1,0,0,0,1,1,1,0,0,0,0,1,1,1,1,0,0,1,1,1,1,1,1,0,1,1,1,1,0,0,1,0)

spline <- smooth.spline(time, ddg, df=10)
plot(time, c(0,rep(1,times=(length(yrs)-1))), type="n", xlab="bienio", ylab="prob(gob.div)", axes="FALSE")
axis(1, at=c(1:length(yrs)), labels = FALSE)
axis(1, tick= FALSE, cex.axis=.55, at=c(1:length(yrs)), labels = yrs, las=2)
axis(2, at=(0:4)/4, labels = (0:4)/4)
lines(c(1,length(yrs)),c(.5,.5),lwd=1,lty=3, col="grey50")
lines(spline, col="red",lwd=2)


#### GRAFICA VERSION EXTENDIDA A LO LARGO EN PDF
setwd("d:/01/mydocs/itam/clases/pc2a10")
oldpar <- par(no.readonly=TRUE)
pdf(file="dgUSspline.pdf",width=7, height=4)
par(mar=c(5,4,0,2)+0.1)  ## USA EL ESPACIO DEL TITULO INEXISTENTE
plot(time, c(0,rep(1,times=(length(yrs)-1))), type="n", xlab="", ylab="prob(gob.div)", axes="FALSE")
axis(1, at=c(1:length(yrs)), labels = FALSE)
axis(1, tick= FALSE, cex.axis=.7, at=c(1:length(yrs)), labels = yrs, las=2)
axis(2, at=(0:4)/4, labels = (0:4)/4)
lines(c(1,length(yrs)),c(.5,.5),lwd=1,lty=3, col="grey50")
lines(spline, col="red",lwd=2)
par(oldpar)
dev.off()




