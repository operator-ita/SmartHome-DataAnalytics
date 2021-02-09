# @Proyecto: Predicción de comportamiento en una casa inteligente
# @Equipo: 14

# En este script se importan los archivos txt que contienen los registros del
# proyecto de domótica "Aras" y se combinan en dos datasets con formato csv.
# Cada uno de los datasets generados contiene los registros de los sensores de
# diferentes casas. Para mas información sobre el dataset original consultar el
# archivo README.txt del dataset Aras.

# Librerías
library(dplyr)
library(data.table)

# Directorio de trabajo
repo.dir <- "C:/Users/luisf/Github/SmartHome-DataAnalytics"
setwd(repo.dir)

# Funciones
importar.dataset = function(directorio, patron){
  ds <- lapply(list.files(path=directorio, pattern=patron), 
                         read.csv, sep=' ') 
  ds <- rbindlist(lapply(ds, rbind, use.names=FALSE))
  ds <- as.data.frame(ds)
  return(ds)
}

insertar.act <- function(df, act.names){
  df <- mutate(df, P1=as.factor(P1_code))
  df <- mutate(df, P2=as.factor(P2_code))
  df.act.names <- act.names
  df$P1 <- revalue(df$P1, df.act.names)
  df$P2 <- revalue(df$P2, df.act.names)
  return(df)
}

insertar.dias <- function(df){
  days <- c()
  for(i in 1:30){
    day.factor <- paste("Day", as.character(i), sep=" ")
    days <- c(days, rep(day.factor, 86400))
  }
  df <- add_column(df, "Day"=as.factor(days), .before="time")
  return(df)
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

# Exportación de datasets limpios
write.csv(houseA, file='../../Clean/houseA.csv', row.names=FALSE)
write.csv(houseB, file='../../Clean/houseB.csv', row.names=FALSE)

# Agregación de información complementaria
# Renombramiento de columnas (Consultar Readme del dataset)
names(houseA) <- c('Ph1', 'Ph2', 'Ir1', 'Fo1', 'Fo2', 'Di3', 'Di4', 'Ph3', 'Ph4',
                   'Ph5', 'Ph6', 'Co1', 'Co2', 'Co3', 'So1', 'So2', 'Di1', 'Di2', 
                   'Te1', 'Fo3', 'P1_code','P2_code')

# Renombramiento de columnas (Consultar Readme del dataset)
names(houseB) <- c('co1', 'co2', 'co3', 'co4', 'co5', 'co6', 'di2', 'fo1', 'fo2',
                   'fo3', 'ph1', 'ph2', 'pr1', 'pr2', 'pr3', 'pr4', 'pr5', 'so1',
                   'so2', 'so3', 'P1_code', 'P2_code') 
# Inserción de columnas de actividades
act.names <- c(
  "1"	= "Other",
  "2" = "Going Out",
  "3" =	"Preparing Breakfast", 
  "4" =	"Having Breakfast", 
  "5" =	"Preparing Lunch", 
  "6" =	"Having Lunch", 
  "7" =	"Preparing Dinner",
  "8" =	"Having Dinner", 
  "9" =	"Washing Dishes", 
  "10" =	"Having Snack", 
  "11" =	"Sleeping", 
  "12" =	"Watching TV", 
  "13" =	"Studying", 
  "14" =	"Having Shower", 
  "15" =	"Toileting", 
  "16" =	"Napping", 
  "17" =	"Using Internet", 
  "18" =	"Reading Book", 
  "19" =	"Laundry",
  "20" =	"Shaving", 
  "21" =	"Brushing Teeth", 
  "22" =	"Talking on the Phone", 
  "23" =	"Listening to Music", 
  "24" =	"Cleaning",
  "25" =	"Having Conversation", 
  "26" =	"Having Guest",
  "27" =	"Changing Clothes")

houseA <- insertar.act(houseA, act.names)
houseB <- insertar.act(houseB, act.names)

head(houseA) ; head(houseB)

# Inserción de columna con datos de tiempo
# Creación de un vector de tiempo 24 hrs, segundo a segundo
day <- format( seq.POSIXt(as.POSIXct(Sys.Date()), as.POSIXct(Sys.Date()+1), 
                          by = "1 s"),
               "%H:%M:%S", tz="GMT")
day <- day[-length(day)]

houseA <- add_column(houseA, "time"=rep(day, 30) ,.before="Ph1")
houseB <- add_column(houseB, "time"=rep(day, 30) ,.before="co1")

# Inserción de columna con días
houseA <- insertar.dias(houseA)
houseB <- insertar.dias(houseB)

head(houseA) ; head(houseB)
tail(houseA) ; tail(houseB)

# Escribiendo datasets modificada
setwd(repo.dir)
write.csv(houseA, file='data/Time/houseA.csv', row.names=FALSE)
write.csv(houseB, file='data/Time/houseB.csv', row.names=FALSE)

setwd(repo.dir)
