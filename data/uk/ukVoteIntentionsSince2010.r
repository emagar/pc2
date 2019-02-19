rm(list=ls())

workdir <- "~/Desktop/pc2/data/uk"
setwd(workdir)

dat <- read.csv(file="ukVoteIntentionsSince2010.csv", stringsAsFactors = FALSE)
head(dat)

library(lubridate)
dat$date <- ymd(paste(dat$yr,"-",dat$mo,"-",dat$dy))
max(dat$lab)

#pdf(file = "ukVoteIntentionsSince2010.pdf", width = 12, height = 7)
#png(file = "ukVoteIntentionsSince2010.png", width = 800, height = 480)
plot( dat$date, c(rep(0, times = (length(dat$date)-1)),  50), type = "n",
     axes = FALSE,
     ylab = "%",
     xlab = "fecha",
     main = "Si hoy fuese la elección general, ¿por quién votaría?")
#
tmp <- seq( from = min(year(dat$date)), to = max(year(dat$date)), by = 1)
axis(side = 1, at = ymd(paste(tmp,"-01-01", sep = "")), labels = tmp, lwd = 1)
tmp <- c(tmp, tmp, tmp, tmp, tmp, tmp, tmp, tmp, tmp, tmp, tmp, tmp)
tmp <- tmp[order(tmp)]
tmp <- ymd(paste(tmp, 1:12, 1, sep = "-"))
tmp[tmp >= min(dat$date) & tmp <= max(dat$date)]
axis(side = 1, at = tmp, labels = FALSE, lwd = .25)
axis(side = 2)
#
abline( h = seq(from = 0, to = 50, by = 5), col = "grey") 
points( dat$date, dat$con, col = "blue", pch=19, cex=.05)
points( dat$date, dat$lab, col = "red", pch=19, cex=.05)
points( dat$date, dat$libDem, col = "gold", pch=19, cex=.05)
points( dat$date, dat$ukip, col = "black", pch=19, cex=.05)
points( dat$date, dat$grn, col = "green", pch=19, cex=.05)
lines(smooth.spline(dat$date, dat$con, df=17),    lwd=3, col="blue")
lines(smooth.spline(dat$date, dat$lab, df=17),    lwd=3, col="red")
lines(smooth.spline(dat$date, dat$libDem, df=10), lwd=3, col="gold")
lines(smooth.spline(dat$date[is.na(dat$ukip)==FALSE], dat$ukip[is.na(dat$ukip)==FALSE], df=10),   lwd=3, col="black")
lines(smooth.spline(dat$date[is.na(dat$grn)==FALSE], dat$grn[is.na(dat$grn)==FALSE], df=10),   lwd=3, col="green")
#
abline(v=c(ymd("2010-05-06"), ymd("2015-05-07"), ymd("2017-06-08"))) # general elections in period
abline(v=  ymd("2014-09-18"), lty=2)              # scottish referendum
abline(v=  ymd("2016-06-23"), lty=2)              # brexit poll
pos <- 2
text(x = c(ymd("2010-05-06"), ymd("2015-05-07"), ymd("2017-06-08")), y = 50, srt = 90, pos = pos, cex = .75, labels="Elección general")
text(x = c(ymd("2014-09-18")), y = 50, srt = 90, pos = pos, cex = .75, labels="Ref. Escocia")
text(x = c(ymd("2016-06-23")), y = 50, srt = 90, pos = pos, cex = .75, labels="Ref. Brexit")
#dev.off()

head(dat)
