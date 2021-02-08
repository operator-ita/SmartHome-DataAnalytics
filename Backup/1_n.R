# @Proyecto: Predicción de comportamiento en una casa inteligente
# @Equipo: 14

# Este dataset calcula el cociente del tiempo dedicado por ambas personas a cada
# actividad por día y grafica la serie de tiempo de dicho cociente.

# Librerías
library(dplyr)
library(tidyr)
#library(ggplot2)
#library(plyr)
#library(reshape2)
#library(ggthemes)

# Directorio de trabajo
repo.dir <- "C:/Users/luisf/Documents/Github/SmartHome-DataAnalytics"
setwd(repo.dir)


# Importación de datasets 
houseA <- read.csv("data/Modified/houseA_time.csv")
houseB <- read.csv("data/Modified/houseB_time.csv")
(houseA.P1 <- select(houseA, Day, time, P1))
(houseB.P2 <- select(houseB, Day, time, P2))
?table
table(houseA$P1)

houseA.P1 %>% group_by(Day, P1) %>% 
  summarise(frec =count(time)) %>% 
  spread(gender, total_loan_amount) %>% 
  ungroup() %>%
  transmute(country = country,  female_percent = F / (F+M), male_percent = M /(F+M))






#todo Linea de tiempo de Q
(houseA.tareas <- mutate(houseA.tareas, Q=P2/P1))
(houseB.tareas <- mutate(houseB.tareas, Q=P2/P1))
#calcular Q por día
#serie de tiempo
