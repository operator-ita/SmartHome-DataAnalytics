# @Proyecto: 
# @Equipo: 14

# En este script se realiza una tabla de frecencia de actividades por día por
# persona de cada casa y se grafican sus series de tiempo 

# Librerías
library(dplyr)
library(plyr)
library(data.table)
library(ggplot2)

# Directorio de trabajo
repo.dir <- "" 
setwd(repo.dir)
 
# Funciones
# Función para agregar una columna de día 
insertar.dia <- function(df, start, end, interval) {
    days.nested <- lapply(seq(start,end), rep, interval) 
    days.flatten <- do.call(c, days)
    df <- mutate(df, day=days.flatten)
  # Agregar columna de día 
    return(df)
}

# Función para realizar frecuencia acomulada por día por persona
freq.tb <- function(col.act, group.by, start, end) {
  ds <- tapply(col.act, group.by, FUN = count, simplify = TRUE)
  ds <- Map(cbind, ds, seq(start,end))
  ds <- rbindlist(lapply(ds, rbind, use.names=FALSE))
  ds <- as.data.frame(ds)
  ds <- na.omit(ds)
  names(ds) <- c('Activities', 'Freq', 'day')
  return(ds)
}

ts.create <- function(df, actividad) {
  # Filtering activity
  df <- df[df==actividad,]
  # df <- na.omit(df)
  vec <- as.vector(t(df$Freq))
  # Convertimos los datos en serie de tiempo con el comando ts
  tsb <- ts(vec, start = 1, end = 30, frequency = 1)
  # Inicio, fin y frecuencia de la serie
  start(tsb); end(tsb); frequency(tsb)  # Inicio, fin y frecuencia de la serie
  # Regresamos la serie de tiempo
  return(tsb)
}

# Importación de datasets 
houseA <- read.csv("data/houses_with_time/houseA_time.csv")
houseB <- read.csv("data/houses_with_time/houseB_time.csv")

# Insertar columna de día 
houseA <- insertar.dia(houseA, start=1, end=30, interval=86400)
houseB <- insertar.dia(houseB, start=1, end=30, interval=86400)

# Tablas de frecuencia  
houseA.p1.freq <- freq.tb(houseA$X21, houseA$day, 1, 30)
houseA.p2.freq <- freq.tb(houseA$X22, houseA$day, 1, 30)

houseA.p1.freq


# Series de tiempo por persona y actividad
a <- ts.create(houseA.p1.freq,1)
b <- ts.create(houseA.p2.freq,2)

# Graficar 
plot(b, main = paste("Serie de tiempo", ylab = "Segundos", xlab = "Días"))


