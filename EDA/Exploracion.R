# @Proyecto: Predicción de comportamiento en una casa inteligente
# @Equipo: 14

# En este script se importan los datasets de las dos casas del proyecto "Aras"
# previamente limpiados y se hace un análisis exploratorio para el planteamiento
# de los problemas del proyecto. Como resultado se genera una versión modificada
# de cada dataset con una coolumna que describe la hora de cada actividad, el día 
# y las actividades realizadas por persona como factor. También se generan tablas
# de frecuencias individuales y conjuntas de las actividades realizadas por los
# habitantes de cada casa.

# Librerías
library(dplyr)
library(plyr)
library(tibble)

# Directorio de trabajo
repo.dir <- "C:/Users/luisf/Github/SmartHome-DataAnalytics"
setwd(repo.dir)

# Funciones
# Función para insertar columna con actividades
insertar.act <- function(df, act.names){
  df <- mutate(df, P1=as.factor(P1_code))
  df <- mutate(df, P2=as.factor(P2_code))
  df.act.names <- act.names
  df$P1 <- revalue(df$P1, df.act.names)
  df$P2 <- revalue(df$P2, df.act.names)
  return(df)
}

# Función para insertar columna con días
insertar.dias <- function(df){
  days <- c()
  for(i in 1:30){
    day.factor <- paste("Day", as.character(i), sep=" ")
    days <- c(days, rep(day.factor, 86400))
  }
  df <- add_column(df, "Day"=as.factor(days), .before="time")
  return(df)
}

# Importación de datasets 
houseA <- read.csv("data/Clean/houseA.csv")
houseB <- read.csv("data/Clean/houseB.csv")

# Exploración
dim(houseA); dim(houseB)
head(houseA); head(houseB)
str(houseA); str(houseB)

# Inserción de columnas de actividades
houseA.act.names <- c(
  "1"	= "Other",
  "2" = "	Going_Out", # Seguridad
  "3" =	"Preparing_Breakfast", # Alimentación
  "4" =	"Having_Breakfast", # Alimentación
  "5" =	"Preparing_Lunch", # Alimentación
  "6" =	"Having_Lunch", # Alimentación
  "7" =	"Preparing_Dinner", # Alimentación
  "8" =	"Having_Dinner", # Alimentación
  "9" =	"Washing_Dishes", 
  "10" =	"Having_Snack", # Alimentación
  "11" =	"Sleeping", # Seguridad, Salud
  "12" =	"Watching_TV", # Salud, Entretenimiento
  "13" =	"Studying", # Salud
  "14" =	"Having_Shower", # Salud
  "15" =	"Toileting", # Salud
  "16" =	"Napping", # Salud, Seguridad
  "17" =	"Using_Internet", # Internet, Entretenimiento
  "18" =	"Reading_Book", # Entretenimiento
  "19" =	"Laundry",
  "20" =	"Shaving", 
  "21" =	"Brushing_Teeth", # Salud
  "22" =	"Talking_on_the_Phone", 
  "23" =	"Listening_to_Music", # Entretenimiento
  "24" =	"Cleaning",
  "25" =	"Having_Conversation", 
  "26" =	"Having_Guest",
  "27" =	"Changing_Clothes")

houseB.act.names <- c(
  "1" =	"Other",
  "2" =	"Going Out",
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

houseA <- insertar.act(houseA, houseA.act.names)
houseB <- insertar.act(houseB, houseB.act.names)

head(houseA) ; head(houseB)

# Inserción de columna con datos de tiempo
# Creación de un vector de tiempo 24 hrs, segundo a segundo
day <- format( seq.POSIXt(as.POSIXct(Sys.Date()), as.POSIXct(Sys.Date()+1), 
                          by = "1 s"),
               "%H:%M:%S", tz="GMT")
day <- day[-length(day)]

houseA <- add_column(houseA, "time"=rep(day, 30) ,.before="Ph1")
houseB <- add_column(houseB, "time"=rep(day, 30) ,.before="co1")

head(houseA) ; head(houseB)

# Inserción de columna con días
houseA <- insertar.dias(houseA)
houseB <- insertar.dias(houseB)

head(houseA) ; head(houseB)
tail(houseA) ; tail(houseB)

# Escribiendo datasets modificada
write.csv(houseA, file='data/Modified/houseA_time.csv', row.names=TRUE)
write.csv(houseB, file='data/Modified/houseB_time.csv', row.names=TRUE)

# Análisis Exploratorio

# Tabla de Frecuecnia de actividades por persona por casa
houseA.P1.Freq <-table(houseA$P1)
houseA.P2.Freq <-table(houseA$P2)
houseB.P1.Freq <-table(houseB$P1)
houseB.P2.Freq <-table(houseB$P2)

View(houseA.P1.Freq) ; View(houseA.P2.Freq)
View(houseB.P1.Freq) ; View(houseB.P2.Freq)

write.csv(houseA.P1.Freq, file='data/Frequency/Freq_houseA_P1.csv', row.names=TRUE)
write.csv(houseA.P2.Freq, file='data/Frequency/Freq_houseA_P2.csv', row.names=TRUE)
write.csv(houseB.P1.Freq, file='data/Frequency/Freq_houseB_P1.csv', row.names=TRUE)
write.csv(houseB.P2.Freq, file='data/Frequency/Freq_houseB_P2.csv', row.names=TRUE)

# Tablas de Contingencia de actividades por casa
houseA.Freq <- table(houseA$P1, houseA$P2)
houseB.Freq <- table(houseB$P1, houseB$P2)

View(houseA.Freq) ; View(houseB.Freq)

write.csv(houseA.Freq, file='data/Frequency/Freq_houseA.csv', row.names=TRUE)
write.csv(houseB.Freq, file='data/Frequency/Freq_houseB.csv', row.names=TRUE)

setwd(repo.dir)
