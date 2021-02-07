# @Proyecto: 
# @Equipo: 14

# En este script se realiza una tabla de frecencia de actividades por día por persona de cada casa 
# y se grafican sus series de tiempo 

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

# Función para graficar serie de tiempo
ts.plot <- function(df, actividad) {
  # Filtering activity
  df <- df[df==actividad, ]
  vec <- as.vector(t(df$Freq))
  # Convertimos los datos en serie de tiempo con el comando ts
  tsb <- ts(vec, start = 1, frequency = 1)
  # Inicio, fin y frecuencia de la serie
  start(tsb); end(tsb); frequency(tsb)  # Inicio, fin y frecuencia de la serie
  # Graficamos la serie de tiempo
  plot(tsb, main = paste("Serie de tiempo", actividad), ylab = "Segundos", xlab = "Días")
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
houseA.p1.freq <- freq.tb(houseA$P1, houseA$day, 1, 30)
houseA.p2.freq <- freq.tb(houseA$P2, houseA$day, 1, 30)

# Series de tiempo por persona y actividad
ts.plot(houseA.p1.freq,"\tGoing_Out")
ts.plot(houseA.p2.freq,"\tGoing_Out")
