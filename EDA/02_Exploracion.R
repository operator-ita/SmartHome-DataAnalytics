# @Proyecto: Predicción de comportamiento en una casa inteligente
# @Equipo: 14

# En este script se importan los datasets de las dos casas del proyecto "Aras"
# previamente limpiados y se hace un análisis exploratorio para el planteamiento
# de los problemas del proyecto. Como resultado se genera una versión modificada
# de cada dataset con una coolumna que describe la hora de cada actividad, el día 
# y las actividades realizadas por persona como factor. También se generan tablas
# de frecuencias individuales y conjuntas de las actividades realizadas por los
# habitantes de cada casa. Y se generan gráficas que resumen y comparan el tiempo
# Invertido por los miembros de cada casa a lo largo del mes.

# Librerías
library(dplyr)
library(plyr)
library(tibble)
library(ggplot2)
library(reshape2)
library(scales)
library(ggthemes)

# Directorio de trabajo
repo.dir <- "C:/Users/luisf/Github/SmartHome-DataAnalytics"
setwd(repo.dir)

# Funciones
frec.comp <- function(df1, df2, act.vec){
  new.df <- merge(df1, df2, by="Var1", all.x=T, check.names=F)
  new.df <- new.df[, c(1,3,5)]
  names(new.df) <- c("Activity", "P1", "P2")
  new.df[is.na(new.df)] <- 0
  new.df <- mutate(new.df, P1=P1/60, P2=P2/60)
  return(new.df)
}

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

# Bar Charts
# Convirtir tablas a dataframes
(freq_table_HA_R1 <- as.data.frame(houseA.P1.Freq))
names(freq_table_HA_R1) <- c("Activity", "Freq")
(freq_table_HA_R2 <- as.data.frame(houseA.P2.Freq))
names(freq_table_HA_R2) <- c("Activity", "Freq")
(freq_table_HB_R1 <- as.data.frame(houseB.P1.Freq))
names(freq_table_HB_R1) <- c("Activity", "Freq")
(freq_table_HB_R2 <- as.data.frame(houseB.P2.Freq))
names(freq_table_HB_R2) <- c("Activity", "Freq")

# Ordenando por frecuencias
freq_table_HA_R1[order(freq_table_HA_R1$Freq, decreasing = TRUE),]    
freq_table_HA_R2[order(freq_table_HA_R2$Freq, decreasing = TRUE),]
freq_table_HB_R1[order(freq_table_HB_R1$Freq, decreasing = TRUE),]
freq_table_HB_R2[order(freq_table_HB_R2$Freq, decreasing = TRUE),]

# Creation of bar charts
images.path <- "images/Frequency/"

bar_HA_R1 <- ggplot(data = freq_table_HA_R1, aes(x = reorder(Activity, Freq), y = Freq)) +
  geom_col(aes(fill = Activity) , show.legend = FALSE) +
  ggtitle(paste("Time spent on each activity by resident 1 in house A during 1 month")) +
  coord_flip() +
  geom_label(aes(label = percent(Freq/sum(Freq), accuracy =  0.001),
                 y = -150, fill = Activity),
             show.legend = FALSE,
             size = 3.5, label.padding = unit(0.1, "lines")) +
  expand_limits(y = -150)+
  labs(x = "Activity", y = "Seconds")
ggsave(images.path + "houseA_P1.png")

(bar_HA_R2 <- ggplot(data = freq_table_HA_R2, aes(x = reorder(Activity, Freq), y = Freq)) +
  geom_col(aes(fill = Activity) , show.legend = FALSE) +
  ggtitle(paste("Time spent on each activity by resident 2 in house A during 1 month")) +
  coord_flip() +
  geom_label(aes(label = percent(Freq/sum(Freq), accuracy =  0.001),
                 y = -150, fill = Activity),
             show.legend = FALSE,
             size = 3.5, label.padding = unit(0.1, "lines")) +
  expand_limits(y = -150)+
  labs(x = "Activity", y = "Seconds"))
ggsave(images.path + "houseA_P2.png")

(bar_HB_R1 <- ggplot(data = freq_table_HB_R1, aes(x = reorder(Activity, Freq), y = Freq)) +
  geom_col(aes(fill = Activity) , show.legend = FALSE) +
  ggtitle(paste("Time spent on each activity by resident 1 in house B during 1 month")) +
  coord_flip() +
  geom_label(aes(label = percent(Freq/sum(Freq), accuracy =  0.001),
                 y = -150, fill = Activity),
             show.legend = FALSE,
             size = 3.5, label.padding = unit(0.1, "lines")) +
  expand_limits(y = -150)+
  labs(x = "Activity", y = "Seconds"))
ggsave(images.path + "houseB_P1.png")

(bar_HB_R2 <- ggplot(data = freq_table_HB_R2, aes(x = reorder(Activity, Freq), y = Freq)) +
  geom_col(aes(fill = Activity) , show.legend = FALSE) +
  ggtitle(paste("Time spent on each activity by resident 2 in house B during 1 month")) +
  coord_flip() +
  geom_label(aes(label = percent(Freq/sum(Freq), accuracy =  0.001),
                 y = -150, fill = Activity),
             show.legend = FALSE,
             size = 3.5, label.padding = unit(0.1, "lines")) +
  expand_limits(y = -150)+
  labs(x = "Activity", y = "Seconds"))
ggsave(images.path + "houseB_P2.png")


# Barras de comparación
images.path <- "images/Comp/houseA_P1.png"











setwd(repo.dir)
