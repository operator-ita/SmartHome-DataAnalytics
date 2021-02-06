# @Proyecto: Predicción de
# @Equipo: 14

# Librerías
library(dplyr)
library(data.table)

# Directorio de trabajo
repo.dir <- "C:/Users/luisf/Github/SmartHome-DataAnalytics"
setwd(repo.dir)

# Funciones
# Función para importar los archivos txt de los datasets del proyecto Aras.
importar.dataset = function(directorio, patron){
  ds <- lapply(list.files(path=directorio, pattern=patron), 
                         read.csv, sep=' ') 
  ds <- rbindlist(lapply(ds, rbind, use.names=FALSE))
  ds <- as.data.frame(ds)
  return(ds)
  }

# Importando datos
# HOUSE A 
setwd("data/Aras/HouseA")
houseA <- importar.dataset(getwd(), "^DAY")

# HOUSE B 
setwd("../HouseB")
houseB <- importar.dataset(getwd(), "^DAY")














names(houseA) <- c('Ph1', 'Ph2', 'Ir1', 'Fo1', 'Fo2', 'Di3', 'Di4', 'Ph3', 'Ph4',
                   'Ph5', 'Ph6', 'Co1', 'Co2', 'Co3', 'So1', 'So2', 'Di1', 'Di2', 
                   'Te1', 'Fo3', 'P1_code','P2_code')


names(houseB) <- c('co1', 'co2', 'co3', 'co4', 'co5', 'co6', 'di2', 'fo1', 'fo2',
                   'fo3', 'ph1', 'ph2', 'pr1', 'pr2', 'pr3', 'pr4', 'pr5', 'so1',
                   'so2', 'so3', 'P1_code', 'P2_code') 



# Save dataframe 
# write.csv(houseA, file='../../Clean/houseA.csv', row.names=FALSE)



# Save dataframe 
# write.csv(houseB, file='../../Clean/houseB.csv', row.names=FALSE)