# @Proyecto: Predicción de comportamiento en una casa inteligente
# @Equipo: 14

# En este script se importan los archivos txt que contienen los registros del
# proyecto de domótica "Aras" y se combinan en dos datasets con formato csv.
# Cada uno de los datasets generados contiene los registros de los sensores de
# diferentes casas. Para mas información sobre el dataset original consultar el
# archivo README.txt del dataset Aras.

# Librerías
library(dplyr)
library(plyr)
library(data.table)

# Directorio de trabajo
repo.dir <- "C:/Users/luisf/Github/SmartHome-DataAnalytics"
setwd(repo.dir)

# Funciones
# Función para importar los archivos txt de los datasets del proyecto Aras.
importar.dataset = function(directorio, patron){
  ds <- lapply(list.files(path=directorio, pattern=patron), 
                         read.csv, sep=' ') 
  ds <- rbindlist(lapply(ds, rbind, use.names=FALSE))
  ds <- as.data.frame(ds)
  return(ds)
  }

# Importación de datos
# HOUSE A 
setwd("data/Aras/HouseA")
houseA <- importar.dataset(getwd(), "^DAY")

# HOUSE B 
setwd("../HouseB")
houseB <- importar.dataset(getwd(), "^DAY")

# Limpieza de datasets
# HouseA
head(houseA); tail(houseA)
names(houseA)
str(houseA)
dim(houseA)

# House B
head(houseB); tail(houseB)
names(houseB)
str(houseB)
dim(houseB)

# Buscando valores vacíos (NA)
sum(is.na.data.frame(houseA)); sum(is.na.data.frame(houseB))

# Renombramiento de columnas (Consultar Readme del dataset)
names(houseA) <- c('Ph1', 'Ph2', 'Ir1', 'Fo1', 'Fo2', 'Di3', 'Di4', 'Ph3', 'Ph4',
                   'Ph5', 'Ph6', 'Co1', 'Co2', 'Co3', 'So1', 'So2', 'Di1', 'Di2', 
                   'Te1', 'Fo3', 'P1_code','P2_code')

# Renombramiento de columnas (Consultar Readme del dataset)
names(houseB) <- c('co1', 'co2', 'co3', 'co4', 'co5', 'co6', 'di2', 'fo1', 'fo2',
                   'fo3', 'ph1', 'ph2', 'pr1', 'pr2', 'pr3', 'pr4', 'pr5', 'so1',
                   'so2', 'so3', 'P1_code', 'P2_code') 

# Exportación de datasets
write.csv(houseA, file='../../Clean/houseA.csv', row.names=FALSE)
write.csv(houseB, file='../../Clean/houseB.csv', row.names=FALSE)

setwd(repo.dir)
