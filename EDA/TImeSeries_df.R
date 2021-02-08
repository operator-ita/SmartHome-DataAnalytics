# Librerías
library(dplyr)
library(plyr)
library(purrr)
library(data.table)
library(ggplot2)
library(zoo) # install.packages("zoo")


# Función para agregar una columna de día 
insertar.dia <- function(df, start, end, interval) {
    days.nested <- lapply(seq(start,end), rep, interval) 
    days.flatten <- do.call(c, days.nested)
    df <- mutate(df, day=days.flatten)
  # Agregar columna de día 
    return(df)
}

# Función para realizar frecuencia acomulada por día por persona PROBANDO 
freq.tb <- function(col.act, group.by, start, end) {
    ds <- tapply(col.act, group.by, FUN = count, simplify = TRUE, default = NA)
    ds <- Reduce(function(x,y)merge(x,y,by="x",all=TRUE), ds)
    ds[is.na(ds)] <- 0
    ds <- as.data.frame(ds)
    names(ds) <- c('Activities', seq(start,end))
    rownames(ds) <- ds$Activities
    return(ds)
}

# Función para realizar frecuencia acomulada por día por persona ERROR
freq.tb <- function(col.act, group.by, start, end) {
  ds <- tapply(col.act, group.by, FUN = count, simplify = TRUE)
  ds <- Map(cbind, ds, seq(start,end))
  ds <- rbindlist(lapply(ds, rbind, use.names=FALSE))
  ds <- as.data.frame(ds)
  ds <- na.omit(ds)
  names(ds) <- c('Activities', 'Freq', 'day')
  return(ds)
}


# Importación de datasets 
houseA <- read.csv("data/houses_with_time/houseA_time.csv")
houseB <- read.csv("data/houses_with_time/houseB_time.csv")

# Insertar columna de día 
houseA <- insertar.dia(houseA, start=1, end=30, interval=86400)
houseB <- insertar.dia(houseB, start=1, end=30, interval=86400)


# Tablas de frecuencia de actividad del día 1 al 30 
houseA.p1.freq <- freq.tb(houseA$P1, houseA$day, 1, 30)
houseA.p2.freq <- freq.tb(houseA$P2, houseA$day, 1, 30)
houseB.p1.freq <- freq.tb(houseB$P1, houseA$day, 1, 30)
houseB.p2.freq <- freq.tb(houseB$P2, houseA$day, 1, 30)


write.csv(houseA.p1.freq , file='houseA-p1-freqbyday.csv', row.names=FALSE)
write.csv(houseA.p2.freq , file='houseA-p2-freqbyday.csv', row.names=FALSE)
write.csv(houseB.p1.freq , file='houseB-p1-freqbyday.csv', row.names=FALSE)
write.csv(houseB.p2.freq , file='houseB-p2-freqbyday.csv', row.names=FALSE)
