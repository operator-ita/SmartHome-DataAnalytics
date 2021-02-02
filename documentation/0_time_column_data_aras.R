# @Proyecto
# @Equipo: 14 

# Loading data
houseA <- read.csv("../../rdata/houseA_.csv")
houseB <- read.csv("../../rdata/houseB_.csv")
str(houseA); str(houseB)

# Vector time for a day
day <- format( seq.POSIXt(as.POSIXct(Sys.Date()), as.POSIXct(Sys.Date()+1), by = "1 s"),
               "%H:%M:%S", tz="GMT")
day <- day[-length(day)]

# Inserting time column
library(tibble)
houseA <- add_column(houseA, "time"=rep(day, 30) ,.before="Ph1")
houseB <- add_column(houseB, "time"=rep(day, 30) ,.before="co1") 
head(houseA) ; head(houseB)

# Writing data
write.csv(houseA, file='../../rdata/houseA_time.csv', row.names=TRUE)
write.csv(houseB, file='../../rdata/houseB_time.csv', row.names=TRUE)
