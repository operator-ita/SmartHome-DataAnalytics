# @Proyecto: Predicci√≥n de comportamiento en una casa inteligente
# @Equipo: 14

# Este script hace una correlaciÛn chi^2 para asociar actividades a personas.

# Librer√≠as
library(dplyr)
library(tidyr)
library(reshape2)
library(imputeTS)
library(ggthemes)
library(zoo)
library(ggplot2)
library(corrplot)
library("graphics")
library("vcd")

# Directorio de trabajo
repo.dir <- "C:/Users/luisf/Github/SmartHome-DataAnalytics"
setwd(repo.dir)
setwd("03_Clasificacion")

houseA <- read.csv('data/Time/houseA.csv')
houseB <- read.csv('data/Time/houseB.csv')

# Primero vamos a remover valores perdidos
# Tablas de contingencia de las dos casas para todas las actividades
houseA_f <- filter(houseA, P1 != 0, P2 != 0)
houseB_f <- filter(houseB, P1 != 0, P2 != 0)

tableA <- table(houseA_f$P1, houseA_f$P2)
rownames(tableA)[1] <- "Going_Out"
colnames(tableA)[1] <- "Going_Out"

tableB <- table(houseB_f$P1, houseB_f$P2)
  
  # Tablas de contingencia para cada persona de la casa
  tableA_P1 <- table(houseA_f$P1)
  tableA_P2 <- table(houseA_f$P2)
  row.names(tableA_P1)[1] <- "Going_Out"
  row.names(tableA_P2)[1] <- "Going_Out"
  tableA_P1 <- tableA_P1[order(row.names(tableA_P1))]
  tableA_P2 <- tableA_P2[order(row.names(tableA_P2))]
  common_act_A <- intersect(row.names(tableA_P1),row.names(tableA_P2)) # Actividades en com˙n casa A
  # AquÌ me doy cuenta que la persona 2 de la casa A no hace cleaning, having 
  # guest, having lunch ni preparing lunch pero sÌ shaving
  tableA_P1_common <- tableA_P1[common_act_A]
  tableA_P2_common <- tableA_P2[common_act_A]
  
  tableB_P1 <- table(houseB_f$P1)
  tableB_P2 <- table(houseB_f$P2)
  tableB_P1 <- tableB_P1[order(row.names(tableB_P1))]
  tableB_P2 <- tableB_P2[order(row.names(tableB_P2))]
  common_act_B <- intersect(row.names(tableB_P1),row.names(tableB_P2)) # Actividades en com˙n casa B
  # AquÌ me doy cuenta que la persona 2 de la casa B no hace cleaning, laundry,
  # listening to music, preparing dinner, preparing lunch ni washing dishes 
  # pero sÌ napping, shaving
  tableB_P1_common <- tableB_P1[common_act_B]
  tableB_P2_common <- tableB_P2[common_act_B]

  # Extrayendo actividades que las parejas hacen al mismo tiempo
  both_A <- diag(as.matrix(tableA[common_act_A,common_act_A]))
  both_B <- diag(as.matrix(tableB[common_act_B,common_act_B]))
  
# Chi cuadrada
houseA_table <- cbind(as.vector(tableA_P1_common),as.vector(tableA_P2_common),as.vector(both_A))
houseB_table <- cbind(as.vector(tableB_P1_common),as.vector(tableB_P2_common),as.vector(both_B))

rownames(houseA_table) <- common_act_A
colnames(houseA_table) <- c("P1","P2","Juntos")

rownames(houseB_table) <- common_act_B
colnames(houseB_table) <- c("P1","P2","Juntos")

      # Tablas de contigencia filtrando actividades triviales/individuales 
      # (going out, brushing teeth, changing clothes, having shower, napping, other, 
      # sleeping, toileting, shaving)
      
      act_triviales_HA_r <- c(1,2,3,10,14,15,20,23) # P1
      act_triviales_HA_c <- c(1,2,3,7,11,12,16,17,20) # P2
      
      act_triviales_HB_r <- c(1,2,4,9,13,18,21) # P1
      act_triviales_HB_c <- c(1,2,3,8,10,11,14,15,18) # P2
      
      tableA_f <- tableA[-act_triviales_HA_r,-act_triviales_HA_c]
      tableB_f <- tableB[-act_triviales_HB_r,-act_triviales_HB_c]

houseA_table <- subset(houseA_table, rownames(houseA_table) %in% rownames(tableA_f))
houseB_table <- subset(houseB_table, rownames(houseB_table) %in% rownames(tableB_f))

chisqA <- chisq.test(houseA_table)
chisqA$observed
round(chisqA$expected,2)
round(chisqA$residuals, 3)

residualsA <- corrplot(t(chisqA$residuals), is.cor = FALSE, 
                       title = "Residuales Casa A")

chisqB <- chisq.test(houseB_table)
chisqB$observed
round(chisqB$expected,2)
round(chisqB$residuals, 3)

residualsB <- corrplot(t(chisqB$residuals), is.cor = FALSE, 
                       title = "Residuales Casa B")









############### Nada m·s se queda lo de arriba hasta ahora
# Filtrando actividades independientes

  # P1 casa A (cleaning, having breakfast, laundry, listening to music)
p1_A_ind <- c(1,2,8,9)
  # P2 casa A (having breakfast, laundry, listening to music, preparing 
  # breakfast)
p2_A_ind <- c(1,5,6,7)

  # P1 casa B (having snack, laundry, listening to music, talking on the phone)
p1_B_ind <- c(6,7,8,14)
  # P2 casa B (having snack, preparing breakfast, talking on the phone)
p2_B_ind <- c(5,6,9)

tableA_f2 <- tableA_f[-p1_A_ind,-p2_A_ind]
tableB_f2 <- tableB_f[-p1_B_ind,-p2_B_ind]

# Cambiando los nombres de las tareas a n˙meros por cuestiones de practicidad
P1_act_A <- rownames(tableA_f2)
P2_act_A <- colnames(tableA_f2)

P1_act_B <- rownames(tableB_f2)
P2_act_B <- colnames(tableB_f2)

rownames(tableA_f2) <- c(1:length(rownames(tableA_f2)))
colnames(tableA_f2) <- c(1:length(colnames(tableA_f2)))

rownames(tableB_f2) <- c(1:length(rownames(tableB_f2)))
colnames(tableB_f2) <- c(1:length(colnames(tableB_f2)))

# VisualizaciÛn de actividades no triviales ni individuales de cada casa

mosaicplot(tableA_f2, shade = TRUE, main = "Actividades en casa A", xlab = 
             "Actividades de P1", ylab = "Actividades de P2")
mosaicplot(tableB_f2, shade = TRUE, main = "Actividades en casa B", xlab = 
             "Actividades de P1", ylab = "Actividades de P2")


assoc(tableA_f2, shade = TRUE, las = 3)
assoc(tableB_f2, shade = TRUE, las = 3)

setwd(repo.dir)
