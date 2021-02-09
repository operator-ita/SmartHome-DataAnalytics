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

# Importación de datasets 
houseA <- read.csv("data/Time/houseA.csv")
houseB <- read.csv("data/Time/houseB.csv")

# Exploración
dim(houseA); dim(houseB)
head(houseA); head(houseB)
str(houseA); str(houseB)

# Análisis Exploratorio

# Tabla de Frecuecnia de actividades por persona por casa
(houseA.P1.Freq <-table(houseA$P1))
(houseA.P2.Freq <-table(houseA$P2))
(houseB.P1.Freq <-table(houseB$P1))
(houseB.P2.Freq <-table(houseB$P2))

write.csv(houseA.P1.Freq, file='data/Frequency/houseA_P1.csv', row.names=FALSE)
write.csv(houseA.P2.Freq, file='data/Frequency/houseA_P2.csv', row.names=FALSE)
write.csv(houseB.P1.Freq, file='data/Frequency/houseB_P1.csv', row.names=FALSE)
write.csv(houseB.P2.Freq, file='data/Frequency/houseB_P2.csv', row.names=FALSE)

# Tablas de Contingencia de actividades por casa
(houseA.Freq <- table(houseA$P1, houseA$P2))
(houseB.Freq <- table(houseB$P1, houseB$P2))

write.csv(houseA.Freq, file='data/Frequency/houseA.csv', row.names=TRUE)
write.csv(houseB.Freq, file='data/Frequency/houseB.csv', row.names=TRUE)








setwd(repo.dir)
