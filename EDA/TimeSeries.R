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
  df <- df[df$Activities==actividad,]
  # df <- na.omit(df)
  vector <- t(as.vector(select(df, 2:31)))
  # Convertimos los datos en serie de tiempo con el comando ts
  tsb <- ts(vector,  start=1,  frequency = frecuency_)
  # Verificamos Inicio, fin y frecuencia de la serie
  start(tsb); end(tsb); frequency(tsb)  # Inicio, fin y frecuencia de la serie
  # Regresamos la serie de tiempo
  return(tsb)
}


# Funcion para guardar graficas
ts.plot.save <- function(ts1, titulo_, ylab_, xlab_, dir) {
  png(paste(dir,".png",sep='')) 
  P <- autoplot(as.zoo(ts1), facet=NULL) + theme_stata() + scale_fill_stata()  + ylab(ylab_) + xlab(xlab_) + ggtitle(titulo_) 
  print(P)
  dev.off()
  return(P)
}

# Funcion para crear graficas
ts.plot <- function(tss) {
  P <- autoplot(as.zoo(tss)/3600, facet=NULL) + theme_stata() + scale_fill_stata()  + ylab('Tiempo acomulado (h)') + xlab('Semana') + ggtitle("Serie de tiempo acomulado por día") 
  return(P)
}

# Función para crear una serie multivariada
ts.multivar <- function(df, activities, start_, frecuency_) {
  sdf <- subset(df, Activities %in% activities)
  rownames(sdf) <- sdf$Activities
  sdf <- select(sdf, 2:31)
  sdf <- t(sdf)
  # Convertimos los datos en serie de tiempo con el comando ts
  tsb <- ts(sdf, start = start_, frequency = frecuency_)
  # Regresamos la serie de tiempo
  return(tsb)
}

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
    dash.ts.act.pers <- function(house,p1, act1, p2, act2) {
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
        
      }

      return(ts.plot(cbind(ts1,ts2)))
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

    # Observamos las graficas históricas de las actividades por persona
    ts.plot.save(houseA.P1.ts.act, "Histórico actividad casa A persona 1", "Actividad", "Semanas", "houseA-P1-historico")
    ts.plot.save(houseA.P2.ts.act, "Histórico actividad casa A persona 2", "Actividad", "Semanas", "houseA-P2-historico")
    ts.plot.save(houseB.P1.ts.act, "Histórico actividad casa B persona 1", "Actividad", "Semanas", "houseB-P1-historico")
    ts.plot.save(houseB.P2.ts.act, "Histórico actividad casa B persona 2", "Actividad", "Semanas", "houseB-P2-historico")

    # Descomponiendo aditivamente las series
    ts.plot.save(decompose(houseA.P1.ts.act), "Descomposición aditiva casa A persona 1", "Actividad", "Semanas", "houseA-P1-historico")
    ts.plot.save(houseA.P2.ts.act, "Histórico actividad casa A persona 2", "Actividad", "Semanas", "houseA-P2-historico")
    ts.plot.save(houseB.P1.ts.act, "Histórico actividad casa B persona 1", "Actividad", "Semanas", "houseB-P1-historico")
    ts.plot.save(houseB.P2.ts.act, "Histórico actividad casa B persona 2", "Actividad", "Semanas", "houseB-P2-historico")


# Series de tiempo acomuladas 

    ## Importamos tablas de frecuencia 
    houseA.p1.freq <- read.csv("data/frequency_tables_days/houseA-p1-freqbyday.csv") 
    houseA.p2.freq <- read.csv("data/frequency_tables_days/houseA-p2-freqbyday.csv")
    houseB.p1.freq <- read.csv("data/frequency_tables_days/houseB-p1-freqbyday.csv")
    houseB.p2.freq <- read.csv("data/frequency_tables_days/houseB-p2-freqbyday.csv")

    houseA.p1.freq$Activities
    houseB.p1.freq$Activities
    
    # Explorando patrones 
    dash.ts.act('A','P2','Napping')    
    dash.ts.act('B','P1','Having Breakfast')    
    
    # Descomposicion
    dash.dec.act('B','P2',"Toileting")

    
    # Explorando relaciones
    dash.ts.act.pers('A','P1',"Toileting", 'P2',"Toileting")
    dash.ts.act.pers('B','P1',"Toileting", 'P1','Having Breakfast')

    
    ## Serie de tiempo multivariada del tiempo acomulado por actividad por persona 
    ### Actividades por categoría 
      aseo         <-   c("Having_Shower", "Toileting","Brushing_Teeth")
      salud        <-   c("Sleeping", "Napping", "Toileting")
      alimentacion <-   c("Preparing_Breakfast", "Having_Breakfast", "Preparing_Lunch", "Having_Lunch", "Preparing_Dinner", "Having_Dinner", "Having_Snack")
      internet     <-   c("Using_Internet")
      ludico       <-   c("Watching_TV", "Reading_Book", "Using_Internet")
      seguridad    <-   c("\tGoing_Out", "Sleeping", "Napping")


      # Estudiando actividades por grupo 
      ts.plot(ts.multivar(houseA.p1.freq,seguridad,1,7))

      ts.plot.save(ts.multivar(houseA.p1.freq,aseo,1,7), "HouseA-P1 activities history", "week", "hour", "houseA-P1-seguridad")
      

    
