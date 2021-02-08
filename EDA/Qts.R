# @Proyecto: Predicción de comportamiento en una casa inteligente
# @Equipo: 14

# Este dataset calcula el cociente del tiempo dedicado por ambas personas a cada
# actividad por día y grafica la serie de tiempo de dicho cociente.

# Librerías
library(dplyr)
library(tidyr)
library(reshape2)
library(imputeTS)
#library(ggplot2)
#library(plyr)
#library(reshape2)
library(ggthemes)

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
  df.Frec <- mutate(df.Frec, Q=(Freq.P1/(Freq.P1+Freq.P2))-(Freq.P2/(Freq.P1+Freq.P2)))
  return(df.Frec)
}

crear.ts <- function(df){
  # Convert dataframe into a contingency table
  df.tbl <- dcast(df, Day ~ Activity, value.var="Q")
  # Removing columns with at least one NA value
    df.tbl <- select_if(df.tbl[-1] , ~ !any(is.na(.)))
  # Removing "0" column
  df.tbl <- df.tbl[-1]
  # Cleaning inf values
  df.tbl <- do.call(data.frame,
                        lapply(df.tbl, function(x) replace(x, is.infinite(x),NA)))
  # Converting houseA into a matrix
  df.mat <- as.matrix(df.tbl)
  df.ts <- ts(df.mat, start=1, end=30, frequency=1)
  return(df.ts)
}

# Importación de datasets 
houseA <- read.csv("data/Modified/houseA_time.csv")
houseB <- read.csv("data/Modified/houseB_time.csv")

#todo Linea de tiempo de Q
# Convert dataframe into a contingency table
#houseB.tbl <- dcast(houseB.Frec, Day ~ Activity, value.var="Q")
# Removing columns with at least one NA value
#View(houseB.tbl)
#houseB.tbl <- select_if(houseB.tbl[-1] , ~ !any(is.na(.)))
# Removing "0" column
#houseB.tbl <- houseB.tbl[-1]
# Cleaning inf values
#houseA.tbl <- do.call(data.frame,
#                      lapply(houseA.tbl, function(x) replace(x, is.infinite(x),NA)))
# Converting houseA into a matrix
#houseB.mat <- as.matrix(houseB.tbl)
#houseB.ts <- ts(houseB.mat, start=1, end=30)
houseA.Frec <- frec.comp(houseA)
houseA.ts <- crear.ts(houseA.Frec)
plot(na_interpolation(houseA.ts, option="linear"))


houseB.Frec <- frec.comp(houseB)
houseB.ts <- crear.ts(houseB.Frec)
plot(na_interpolation(houseB.ts, option="linear"))
