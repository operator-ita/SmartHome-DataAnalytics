houseA <- read.csv('./data/rdata/houseA_.csv')
houseB <- read.csv('./data/rdata/houseB_.csv')

# Primero vamos a remover valores perdidos
library(dplyr)

# Tablas de contingencia de las dos casas para todas las actividades
houseA_f <- filter(houseA, P1 != 0, P2 != 0)
houseB_f <- filter(houseB, P1 != 0, P2 != 0)

tableA <- table(houseA_f$P1, houseA_f$P2)
tableB <- table(houseB_f$P1, houseB_f$P2)

# Tablas de contigencia filtrando actividades triviales/individuales 
# (going out, brushing teeth, changing clothes, having shower, napping, other, 
# sleeping, toileting, shaving)

act_triviales_HA_r = c(1,2,3,10,14,15,20,23) # P1
act_triviales_HA_c = c(1,2,3,7,11,12,16,17,20) # P2

act_triviales_HB_r = c(1,2,4,9,13,18,21) # P1
act_triviales_HB_c = c(1,2,3,8,10,11,14,15,18) # P2

tableA_f <- tableA[-act_triviales_HA_r,-act_triviales_HA_c]
tableB_f <- tableB[-act_triviales_HB_r,-act_triviales_HB_c]

# Filtrando actividades independientes

  # P1 casa A (cleaning, having breakfast, laundry, listening to music)
p1_A_ind = c(1,2,8,9)
  # P2 casa A (having breakfast, laundry, listening to music, preparing 
  # breakfast)
p2_A_ind = c(1,5,6,7)

  # P1 casa B (having snack, laundry, listening to music, talking on the phone)
p1_B_ind = c(6,7,8,14)
  # P2 casa B (having snack, preparing breakfast, talking on the phone)
p2_B_ind = c(5,6,9)

tableA_f2 <- tableA_f[-p1_A_ind,-p2_A_ind]
tableB_f2 <- tableB_f[-p1_B_ind,-p2_B_ind]

# Visualización
require(vcd)
mosaic(tableA_f, shade=T, legend=T)
assoc(tableA_f, shade=T, legend=T)

library(ztable)
library(magrittr)

options(ztable.type="html")

z = ztable(tableA, caption = "Tabla de contingencia de las personas en la 
           casa A")

# Chi^2