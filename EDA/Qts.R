# @Proyecto: Predicción de comportamiento en una casa inteligente
# @Equipo: 14

# Este dataset calcula el cociente del tiempo dedicado por ambas personas a cada
# actividad por día y grafica la serie de tiempo de dicho cociente.

# Librerías
library(dplyr)
library(tidyr)
library(reshape2)
#library(ggplot2)
#library(plyr)
#library(reshape2)
#library(ggthemes)

# Directorio de trabajo
repo.dir <- "C:/Users/luisf/Documents/Github/SmartHome-DataAnalytics"
setwd(repo.dir)

#Funciones
frec.comp <- function(df){
  df.P1 <- table(df$P1, df$Day)
  df.P2 <- table(df$P2, df$Day)
  df.P1.m <- melt(df.P1)
  df.P2.m <- melt(df.P2)
  df.Frec <- merge(df.P1.m, df.P2.m, by=c("Var1", "Var2"), all.x=T)
  df.Frec <- df.Frec[, c(2,1,3,4)]
  names(df.Frec) <- c("Day", "Activity", "Freq.P1", "Freq.P2") 
  df.Frec <- mutate(df.Frec, Q=Freq.P1/Freq.P2)
  return(df.Frec)
}


# Importación de datasets 
houseA <- read.csv("data/Modified/houseA_time.csv")
houseB <- read.csv("data/Modified/houseB_time.csv")

houseA.Frec <- frec.comp(houseA)
houseB.Frec <- frec.comp(houseB)
View(houseA.Frec)
#todo Linea de tiempo de Q

# Convert dataframe into a contingency table
houseA.tbl <- dcast(houseA.Frec, Day ~ Activity, value.var="Q")
# Removing columns with at least one NA value
houseA.tbl <- select_if(houseA.tbl , ~ !any(is.na(.)))
# Removing Day and useless columns
house.tbl.cl <- select(house.tbl, Sleeping, Toileting, Washing_Dishes, Going_Out,Brushing )

houseA.mat <- as.matrix(houseA.tbl[-1])


names(houseA.tbl)

houseA.ts <- ts(houseA.mat, start=1, end=30)
plot(houseA.ts[,5])
dev.off
houseB.tbl <- dcast(houseB.Frec, Day ~ Activity, value.var="Q")
