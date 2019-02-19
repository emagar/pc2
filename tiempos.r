setwd("~/Desktop/pc2")

runif(26)

library(lubridate)

times <- data.frame( start = rep(ymd_hms("2017-05-26 13:10:00"), 26), end = rep(ymd_hms("2017-05-26 13:17:00"), 26))
for (i in 2:9){
    times$start[i] <- times$start[i-1] + minutes(8)
    times$end[i] <- times$end[i-1] + minutes(8)
}
times$end[9]

times$start[10] <- ymd_hms("2017-05-26 15:05:00")
times$end[10] <-   ymd_hms("2017-05-26 15:12:00")
for (i in 11:18){
    times$start[i] <- times$start[i-1] + minutes(8)
    times$end[i] <- times$end[i-1] + minutes(8)
}
times$end[18]

times$start[19] <- ymd_hms("2017-05-26 16:40:00")
times$end[19] <-   ymd_hms("2017-05-26 16:47:00")
for (i in 20:26){
    times$start[i] <- times$start[i-1] + minutes(8)
    times$end[i] <- times$end[i-1] + minutes(8)
    }

times

hour(times[,1])
minute(times[,1])


