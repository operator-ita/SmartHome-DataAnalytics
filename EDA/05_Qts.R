# @Proyecto: Predicción de comportamiento en una casa inteligente
# @Equipo: 14

# Este dataset calcula el cociente del tiempo dedicado por ambas personas a cada
# actividad por día y grafica la serie de tiempo de dicho cociente.

# Librerías
library(dplyr)
library(tidyr)
library(reshape2)
library(imputeTS)
library(ggthemes)
library(zoo)

# Directorio de trabajo
repo.dir <- "C:/Users/luisf/Github/SmartHome-DataAnalytics"
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
houseA <- read.csv("data/Time/houseA.csv")
houseB <- read.csv("data/Time/houseB.csv")

houseA <- mutate(houseA, time=as.POSIXct(time, format="%H:%M:%S"))
houseB <- mutate(houseB, time=as.POSIXct(time, format="%H:%M:%S"))

# House A
houseA.Frec <- frec.comp(houseA)
houseA.ts <- crear.ts(houseA.Frec)

tv.ts <- houseA.ts[,10]
(P <- autoplot(as.zoo(tv.ts), facet=NULL) + 
  theme_stata() + scale_fill_stata()  +
    ggtitle(paste("Time series of Q - Watching tv")) +
    labs(x = "Days", y = "Q"))
ggsave("A_tv_ts.png")

dishes.ts <-houseA.ts[,9]
(P <- autoplot(as.zoo(dishes.ts), facet=NULL) + 
    theme_stata() + scale_fill_stata()  +
    ggtitle(paste("Time series of Q - Washing dishes")) +
    labs(x = "Days", y = "Q"))
ggsave("A_dishes_ts.png")
  


plot(na_interpolation(houseA.ts, option="linear"))
ggsave("Q_houseA.png")

plot(na_interpolation(houseB.ts, option="linear"))
ggsave("Q_houseB.png")
