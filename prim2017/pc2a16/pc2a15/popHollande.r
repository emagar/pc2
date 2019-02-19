# datos de www.ifop.com
library(lubridate)

mo <- c(    5:12,         1:12,       1:12,          1:12,          1:9)
yr <- c(rep(2012,8), rep(2013,12), rep(2014,12), rep(2015,12), rep(2016,9))
dy <- rep(1, 41) # fictional
date <- ymd(paste(yr, mo, dy, sep="-"))
mo <- floor_date(date, "month") # generate month/yr indicator
aprueban <-    c(61, 59, 56, 54, 43, 42, 41, 37, 38, 37, 31, 25, 29, 26, 27, 28, 23, 23, 20, 22, 22, 20, 23, 18, 18, 18, 18, 17, 13, 14, 13, 17, 29, 24, 25, 21, 21, 22, 22, 24, 23, 20, 27, 27, 24, 19, 17, 14, 15, 14, 17, 16, 15)
desaprueban <- c(33, 40, 44, 45, 56, 57, 58, 62, 62, 62, 68, 74, 71, 73, 72, 71, 76, 77, 79, 78, 77, 79, 76, 82, 82, 81, 81, 81, 86, 84, 85, 82, 70, 76, 75, 78, 78, 77, 77, 75, 77, 79, 73, 73, 75, 81, 82, 85, 84, 85, 82, 82, 84)
neto <- aprueban - desaprueban
hollande <- data.frame(mo=mo, aprueban=aprueban, desaprueban=desaprueban, neto=neto)

mo <- c(5:12,1:12,1:3)
yr <- c(rep(2012,8), rep(2013,12), rep(2014,3))
dy <- rep(1, 23) # fictional
date <- ymd(paste(yr, mo, dy, sep="-"))
mo <- floor_date(date, "month") # generate month/yr indicator
aprueban <-    c(65, 65, 61, 57, 50, 49, 43, 35, 38, 37, 36, 30, 33, 31, 30, 30, 30, 28, 23, 24, 26, 26, 26)
desaprueban <- c(22, 29, 37, 37, 46, 49, 55, 63, 60, 60, 61, 67, 66, 64, 64, 64, 66, 70, 74, 75, 71, 71, 71)
neto <- aprueban - desaprueban
ayrault <- data.frame(mo=mo, aprueban=aprueban, desaprueban=desaprueban, neto=neto)

# valls
mo <- c(     4:12,        1:12,          1:9)
yr <- c(rep(2014,9), rep(2015,12), rep(2016,9))
dy <- rep(1, 30) # fictional
date <- ymd(paste(yr, mo, dy, sep="-"))
mo <- floor_date(date, "month")
aprueban <-    c(58, 56, 51, 45, 36, 35, 36, 37, 35, 53, 46, 45, 40, 37, 35, 40, 43, 39, 36, 39, 38, 39, 33, 27, 25, 22, 21, 21, 24, 24)
desaprueban <- c(35, 41, 45, 51, 59, 61, 61, 60, 62, 45, 53, 55, 59, 62, 64, 58, 56, 60, 63, 60, 62, 60, 66, 72, 74, 77, 78, 76, 73, 75)
neto <- aprueban - desaprueban
valls <- data.frame(mo=mo, aprueban=aprueban, desaprueban=desaprueban, neto=neto)

png(file = "/home/eric/Desktop/pc2/popHollande.png")
plot(c(min(hollande$mo), max(hollande$mo)), c(min(hollande$neto), max(ayrault$neto)), type = "n", main = "Aprobación neta (may2012-sep2016)", xlab = "mes", ylab = "%aprueban - % desaprueban")
abline(h=0, lty=2)
axis(1, at = hollande$mo, tck = -.01, labels = FALSE)
lines(hollande$mo, hollande$neto, lwd = 2, col="red")
lines(ayrault$mo, ayrault$neto, lwd = 2, col="deeppink")
lines(valls$mo, valls$neto, lwd = 2, col="blue")
text(ayrault$mo[23], ayrault$neto[23], "Ayrault", pos = 3)
text(valls$mo[1], valls$neto[1], "Valls", pos = 3)
text(hollande$mo[25], hollande$neto[25], "Hollande", pos = 1)
dev.off()

