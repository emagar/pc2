rm(list = ls())
setwd("~/Desktop/pc2/examenFinalCanada/")

dat <- read.csv(file = "canadaGE2015results.csv", stringsAsFactors = FALSE)

# province numeric codes
dat$provn <- as.integer(dat$disn/1000)
# n districts by province
tmp <- dat[duplicated(dat$disn)==FALSE,]
tmp <- table(tmp$provn)
tmp <- as.data.frame(tmp); colnames(tmp) <- c("provn","ndis")
dat <- merge(x = dat, y = tmp, by = "provn", all.x = TRUE, all.y = FALSE)
# report
sel <- duplicated(dat$provn)==FALSE
data.frame(provn=dat$provn[sel], prov=dat$prov[sel], ndis=dat$ndis[sel])
rm(sel)

# keep validated reports (drop each district's preliminary)
table(dat$typRes)
dat <- dat[dat$typRes=="validated",]; dat$typRes <- NULL
# drop french labels
dat$disf <- dat$typResf <- dat$ptyf <- NULL

# winner
dat <- ddply(dat, .(disn), mutate, max = max(v)) # district maximum v
dat$dwin <- ifelse(dat$v==dat$max, 1, 0)
dat$max <- NULL

# enp
library(plyr)
tmp <- ddply(dat, .(pty), mutate, v = sum(v)) # pty natl aggregates
tmp <- tmp[duplicated(tmp$pty)==FALSE, c("pty", "v")]
tmp$vs <- tmp$v / sum(tmp$v)
# national enp
1 / sum(tmp$vs^2)
# median district enp
tmp <- ddply(dat, .(disn), mutate, enp = 1/sum((vs/100)^2))
median(tmp$enp)


# party national aggregates (to drop small parties)
v.pty <- ddply(dat, .(pty), mutate, nwin = sum(dwin), vt = sum(v))
v.pty$v <- v.pty$vt; v.pty$vt <- NULL
v.pty <- v.pty[duplicated(v.pty$pty)==FALSE,]
v.pty <- v.pty[, c("pty","v","nwin")]
v.pty$vs <- round(v.pty$v / sum(v.pty$v), 4)
dim(v.pty) # all parties fielding candidates
v.pty[v.pty$vs>.025 | v.pty$nwin>0,]
# drop parties with less than 1% and no wins
keep <- which(dat$pty %in% c("Bloc Québécois", "Conservative", "Green Party", "Liberal", "NDP-New Democratic Party"))
dat <- dat[keep,]
rm(keep)
# simplify party labels
dat$pty[grep("Bloc", dat$pty)] <- "BQ"
dat$pty[grep("Conservative", dat$pty)] <- "Cons"
dat$pty[grep("Green", dat$pty)] <- "Green"
dat$pty[grep("Liberal", dat$pty)] <- "Lib"
dat$pty[grep("New", dat$pty)] <- "NDP"
# recompute vtot and vs
dat <- ddply(dat, .(disn), mutate, vtot = sum(v))
dat <- ddply(dat, .(disn), mutate, vs = round(v/vtot,3))

# party national aggregates fptp
fptp <- ddply(dat, .(pty), mutate, s = sum(dwin), v = sum(v))
fptp <- fptp[duplicated(fptp$pty)==FALSE,]
fptp <- fptp[, c("pty","v","s")]
fptp$vs <- round(fptp$v / sum(fptp$v), 3)
fptp$ss <- round(fptp$s / sum(fptp$s), 3)
fptp
#
# enlp national
1/sum(fptp$ss^2)
# median district enp
tmp <- ddply(dat, .(disn), mutate, enp = 1/sum(vs^2))
tmp <- tmp[duplicated(tmp$disn)==FALSE, c("provn","disn","prov","dis","enp")]
median(tmp$enp)


# asignación con d'hondt (distritos son provincias, magnitud = apportionment actual)
tmp <- dat; tmp$pty2 <- as.numeric(as.factor(tmp$pty)); tmp$id <- tmp$provn + tmp$pty2/10
tmp <- ddply(tmp, .(id), mutate, v = sum(v)) # party province v aggregates
tmp <- tmp[duplicated(tmp$id)==FALSE,]
tmp <- ddply(tmp, .(provn), mutate, vs = round(v / sum(v), 3)) # party provincial v shares
div <- cbind(tmp$v, tmp$v/2, tmp$v/3, tmp$v/4, tmp$v/5, tmp$v/6, tmp$v/7, tmp$v/8, tmp$v/9,
  tmp$v/10, tmp$v/11, tmp$v/12, tmp$v/13, tmp$v/14, tmp$v/15, tmp$v/16, tmp$v/17, tmp$v/18, tmp$v/19, 
  tmp$v/20, tmp$v/21, tmp$v/22, tmp$v/23, tmp$v/24, tmp$v/25, tmp$v/26, tmp$v/27, tmp$v/28, tmp$v/29, 
  tmp$v/30, tmp$v/31, tmp$v/32, tmp$v/33, tmp$v/34, tmp$v/35, tmp$v/36, tmp$v/37, tmp$v/38, tmp$v/39, 
  tmp$v/40, tmp$v/41, tmp$v/42, tmp$v/43, tmp$v/44, tmp$v/45, tmp$v/46, tmp$v/47, tmp$v/48, tmp$v/49, 
  tmp$v/50, tmp$v/51, tmp$v/52, tmp$v/53, tmp$v/54, tmp$v/55, tmp$v/56, tmp$v/57, tmp$v/58, tmp$v/59, 
  tmp$v/60, tmp$v/61, tmp$v/62, tmp$v/63, tmp$v/64, tmp$v/65, tmp$v/66, tmp$v/67, tmp$v/68, tmp$v/69, 
  tmp$v/70, tmp$v/71, tmp$v/72, tmp$v/73, tmp$v/74, tmp$v/75, tmp$v/76, tmp$v/77, tmp$v/78, tmp$v/79, 
  tmp$v/80, tmp$v/81, tmp$v/82, tmp$v/83, tmp$v/84, tmp$v/85, tmp$v/86, tmp$v/87, tmp$v/88, tmp$v/89, 
  tmp$v/90, tmp$v/91, tmp$v/92, tmp$v/93, tmp$v/94, tmp$v/95, tmp$v/96, tmp$v/97, tmp$v/98, tmp$v/99,
  tmp$v/100, tmp$v/101, tmp$v/102, tmp$v/103, tmp$v/104, tmp$v/105, tmp$v/106, tmp$v/107, tmp$v/108, tmp$v/109,
  tmp$v/110, tmp$v/111, tmp$v/112, tmp$v/113, tmp$v/114, tmp$v/115, tmp$v/116, tmp$v/117, tmp$v/118, tmp$v/119,
  tmp$v/120, tmp$v/121) # max magnitude is 121
div <- round(div, 1)
prv <- c(10, 11, 12, 13, 24, 35, 46, 47, 48, 59, 60, 61, 62)
for (i in 1:length(prv)){
    #i <- 1 # debug
    sel <- which(tmp$provn==prv[i])
    tmp2 <- div[sel,] # select province's party quotients
    tmp2 <- matrix(rank(as.vector(-tmp2)), ncol=ncol(tmp2)) # order from large to small by province
    div[sel,] <- tmp2
}
div <- as.data.frame(div)
div <- cbind( data.frame(prov=tmp$prov, provn=tmp$provn, pty=tmp$pty, id=tmp$id, m=tmp$ndis, v=tmp$v, vs=tmp$vs), div) # add province and party nums
# seats party won in each district
for (i in 1:nrow(div)){
    #i <- 3 #debug
    tmp <- div[i, grep("V", colnames(div))]
    div$s[i] <- length(which(tmp <= div$m[i]))
}
div$ss <- round(div$s / div$m, 3)
dhondt <- div[, c("prov","provn","m", "pty", "v", "s", "vs", "ss")]
#
rm(div, i, prv, sel, tmp, tmp2, v.pty)
#
# by province/pty
ddply(dhondt, .(prov, pty), summarise, v=v, vs=vs, s=s, ss=ss) # party province v aggregates
# nationwide
tmp <- ddply(dhondt, .(pty), mutate, v=sum(v), s=sum(s)) # natl party aggregates
tmp <- tmp[duplicated(tmp$pty)==FALSE,]
tmp$ss <- round(tmp$s / sum(tmp$s), 3)
tmp$vs <- round(tmp$v / sum(tmp$v), 3)
dhondt <- tmp[, c("pty","v","s","vs","ss")]
dhondt
# enlp national
1/sum(dhondt$ss^2)


# asignación con mmp
tmp <- dat; tmp$pty2 <- as.numeric(as.factor(tmp$pty)); tmp$id <- tmp$provn + tmp$pty2/10
tmp <- ddply(tmp, .(id), mutate, v = sum(v), s0 = sum(dwin)) # party province v and fptp (s0) seat aggregates
tmp <- tmp[duplicated(tmp$id)==FALSE,]; tmp$disn <- tmp$dis <- tmp$surname <- tmp$mid <- tmp$name <- NULL
tmp <- ddply(tmp, .(provn), mutate, vtot = sum(v)) # total votes province
tmp$m <- as.integer(tmp$ndis *2/3) + 1 # two-thirds rounded up
tmp$q <- tmp$vtot / tmp$m # Hare quota
tmp$s1 <- as.integer(tmp$v / tmp$q) # allocate full-quota seats
tmp$rem <- tmp$v - tmp$s1 * tmp$q # remainders
tmp <- ddply(tmp, .(provn), mutate, leftover = m - sum(s1)) # unallocated seats
tmp <- ddply(tmp, .(provn), mutate, ord = rank(-v)) # rank remainder votes
tmp$s2 <- ifelse(tmp$ord <= tmp$leftover, 1, 0) # allocate by remainders
tmp$s <- tmp$s0 + tmp$s1 + tmp$s2 # add fptp and hare seats by pty-prov
tmp <- ddply(tmp, .(pty), mutate, s = sum(s), v = sum(v)) # national aggregates
tmp <- tmp[duplicated(tmp$pty)==FALSE,]; tmp$prov <- tmp$provn <- NULL
tmp$vs <- round(tmp$v / sum(tmp$v), 3) # party national v shares
tmp$ss <- round(tmp$s / sum(tmp$s), 3) # party national s shares
#
mmp <- tmp[, c("pty","v","s","vs","ss")]
mmp
# enlp national
1/sum(mmp$ss^2)


# report
fptp
dhondt
mmp

# v-s plot
plot(c(0,.6), c(0,.6), type = "n", xlab = "votos", ylab = "escaños", main = "fptp=negro, d'hondt=rojo, mmp=azul")
abline(a = 0, b = 1, lty = 2)
points(fptp$vs, fptp$ss)
points(dhondt$vs, dhondt$ss, col = "red")
points(mmp$vs, mmp$ss, col = "blue")
text(fptp$vs+.035, fptp$ss, fptp$pty)





