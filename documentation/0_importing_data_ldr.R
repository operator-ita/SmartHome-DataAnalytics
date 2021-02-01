library(dplyr)
setwd(paste(getwd(),'data/ldr', sep='/'))



Sconf <- read.csv(list.files())
Sconf <- rename(Sconf,R=Kohms, d=Distancia.cm., Exp=Experimento)

head(Sconf)
str(Sconf)

write.csv(Sconf,'ldrF.csv', row.names=FALSE)
