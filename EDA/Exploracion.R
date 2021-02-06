# @Proyecto: Predicción de comportamiento en una casa inteligente
# @Equipo: 14

# En este script se importan los datasets de las dos casas del proyecto "Aras"
# previamente limpiados y se hace un análisis exploratorio para el planteamiento
# de los problemas del proyecto.

# Librerías
library(dplyr)
library(plyr)

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

# Directorio de trabajo
repo.dir <- "C:/Users/luisf/Documents/Github/SmartHome-DataAnalytics"
setwd(repo.dir)

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

head(houseA)
head(houseB)





