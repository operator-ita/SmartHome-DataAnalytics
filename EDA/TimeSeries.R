# @Proyecto: 
# @Equipo: 14

# En este script se realiza una tabla de frecencia de actividades por día por persona de cada casa 
# y se grafican sus series de tiempo 

# Librerías
library(dplyr)
library(plyr)
library(purrr)
library(data.table)
library(ggplot2)
library(zoo) # install.packages("zoo")
library(ggthemes) # install.packages("ggthemes")

# Directorio de trabajo
repo.dir <- "" 
setwd(repo.dir)
 
# Funciones
# Función para crear una serie univariada
ts.univar <- function(df, actividad, start_, frecuency_) {
  # Filtering activity
  df <- df[df==actividad,]
  # df <- na.omit(df)
  vec <- as.vector(t(df$Freq))
  # Convertimos los datos en serie de tiempo con el comando ts
  tsb <- ts(vec,  start=start_, frequency = frecuency_)
  # Verificamos Inicio, fin y frecuencia de la serie
  start(tsb); end(tsb); frequency(tsb)  # Inicio, fin y frecuencia de la serie
  # Regresamos la serie de tiempo
  return(tsb)
}


# Funcion para guardar graficas
ts.plot.save <- function(ts1, titulo_, ylab_, xlab_, dir) {
  jpeg(paste(dir,".jpeg",sep='')) 
  plot(ts1, main = titulo_, ylab = ylab_, xlab = xlab_)
  dev.off()
}

# Funcion para crear graficas
ts.plot <- function(tss) {
  P <- autoplot(as.zoo(tss)/3600, facet=NULL) + theme_stata() + scale_fill_stata()  + ylab('Tiempo acomulado (h)') + xlab('Semana') 
  return(P)
}

# Función para crear una serie multivariada
ts.multivar <- function(df, activities, start_, frecuency_) {
  df <- subset(df, Activities %in% activities)
  sdf <- split(df, activities, drop = FALSE)
  sdf <- reduce(sdf, full_join, by = "day");
  sdf <- select(sdf, starts_with("Freq"))
  # Inicio, fin y frecuencia de la serie
  #start(sdf); end(sdf); frequency(sdf)  
  # Convertimos los datos en serie de tiempo con el comando ts
  tsb <- ts(sdf, start = start_, frequency = frecuency_)
  # Regresamos la serie de tiempo
  return(tsb)
}



# Serie de tiempo univariada del historico por actividad por persona

    ## Importamos datos 
    houseA <- read.csv("data/houses_with_time/houseA_time.csv")
    houseB <- read.csv("data/houses_with_time/houseB_time.csv")

    ## Serie de actividades por persona por día del día 1 al 30  
    houseA.P1.ts.act <- ts(as.vector(t(houseA$X21)), start=1, end=7, frequency=86400)
    houseA.P2.ts.act <- ts(as.vector(t(houseA$X22)), start=1, end=7, frequency=86400)
    houseB.P1.ts.act <- ts(as.vector(t(houseB$X21)), start=1, end=7, frequency=86400)
    houseB.P2.ts.act <- ts(as.vector(t(houseB$X22)), start=1, end=7, frequency=86400)

    # Observamos las graficas
    ts.plot.save(houseA.P1.ts.act/3600, "HouseA-P1 activities history", "week", "hour", "houseA-P1-act")
    ts.plot.save(houseA.P2.ts.act/3600, "HouseA-P1 activities history", "week", "hour", "houseA-P2-act")
    ts.plot.save(houseB.P1.ts.act/3600, "HouseA-P1 activities history", "week", "hour", "houseB-P1-act")
    ts.plot.save(houseB.P2.ts.act/3600, "HouseA-P1 activities history", "week", "hour", "houseB-P2-act")


# Series de tiempo acomuladas 

    ## Importamos tablas de frecuencia 
    houseA.p1.freq <- read.csv("data/frequency_tables/houseA-p1-freq.csv") 
    houseA.p2.freq <- read.csv("data/frequency_tables/houseA-p2-freq.csv")
    houseB.p1.freq <- read.csv("data/frequency_tables/houseB-p1-freq.csv")
    houseB.p2.freq <- read.csv("data/frequency_tables/houseB-p2-freq.csv")

    
    # Explorando patrones 
    dash.ts.act('A','P1','Toileting')    
    
    # Descomposicion
    dash.dec.act('B','P2',"Toileting")

    # Explorando relaciones
    dash.ts.act.p('B','P1',"Toileting", 'P2',"Toileting")
    dash.ts.act.p('B','P1',"Toileting", 'P1','Having_Breakfast')


    ## Serie de tiempo multivariada del tiempo acomulado por actividad por persona 
    ### Actividades por categoría 
      aseo         <-   c("Having_Shower", "Toileting","Brushing_Teeth")
      salud        <-   c("Sleeping", "Napping", "Toileting")
      alimentacion <-   c("Preparing_Breakfast", "Having_Breakfast", "Preparing_Lunch", "Having_Lunch", "Preparing_Dinner", "Having_Dinner", "Having_Snack")
      internet     <-   c("Using_Internet")
      ludico       <-   c("Watching_TV", "Reading_Book", "Using_Internet")
      seguridad    <-   c("\tGoing_Out", "Sleeping", "Napping")


      ts.plot.save(ts.multivar(houseA.p1.freq,aseo,1,7), "HouseA-P1 activities history", "week", "hour", "houseA-P1-seguridad")
      

    # Buscador de relaciones de actividad por persona en una casa 
    dash.ts.act <- function(house, person, activity) {
      if(house=='A'){
        if(person=='P1'){
          P1 <- ts.univar(houseA.p1.freq,activity,1,7)
          return(ts.plot(P1))
        }else if (person=='P2') {
          P2 <- ts.univar(houseA.p2.freq,activity,1,7)
          return(ts.plot(P2))
        }
      }
      if(house=='B'){
        if(person=='P1'){
          P1 <- ts.univar(houseB.p1.freq,activity,1,7)
          return(ts.plot(P1))
        }else if (person=='P2') {
          P2 <- ts.univar(houseB.p2.freq,activity,1,7)
          return(ts.plot(P2))
        }
      }
    }

    # Buscador de relaciones de actividad por persona en una casa 
    dash.dec.act <- function(house, person, activity) {
      if(house=='A'){
        if(person=='P1'){
          P1 <- ts.univar(houseA.p1.freq,activity,1,7)
          return(plot(decompose(P1)))
        }else if (person=='P2') {
          P2 <- ts.univar(houseA.p2.freq,activity,1,7)
          return(plot(decompose(P2)))
        }
      }

      if(house=='B'){
        if(person=='P1'){
          P1 <- ts.univar(houseB.p1.freq,activity,1,7)
          return(plot(decompose(P1)))
        }else if (person=='P2') {
          P2 <- ts.univar(houseB.p2.freq,activity,1,7)
          return(plot(decompose(P2)))
        }
      }
    }

    # Buscador de relaciones por casa 
    dash.ts.act.p <- function(house,p1, act1, p2, act2) {
      if(house=='A'){
        if(p1=='P1'){
          ts1 <- ts.univar(houseA.p1.freq,act1,1,7)
        }else if (p1=='P2') {
          ts1 <- ts.univar(houseA.p2.freq,act1,1,7)
        }
        
        if(p2=='P1'){
          ts2 <- ts.univar(houseA.p1.freq,act2,1,7)
        }else if (p2=='P2') {
          ts2 <- ts.univar(houseA.p2.freq,act2,1,7)
        }
        
        P <- autoplot(as.zoo(cbind(ts1,ts2)), facet=NULL)
        return(P)
      }
      if(house=='B'){
        if(p1=='P1'){
          ts1 <- ts.univar(houseB.p1.freq,act1,1,7)
        }else if (p1=='P2') {
          ts1 <- ts.univar(houseB.p2.freq,act1,1,7)
        }
        
        if(p2=='P1'){
          ts2 <- ts.univar(houseB.p1.freq,act2,1,7)
        }else if (p2=='P2') {
          ts2 <- ts.univar(houseB.p2.freq,act2,1,7)
        }
        
        P <- autoplot(as.zoo(cbind(ts1,ts2)), facet=NULL)
        return(P)
      }
    }


