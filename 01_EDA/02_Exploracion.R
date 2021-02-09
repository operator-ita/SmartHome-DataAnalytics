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
  new.df <- merge(df1, df2, by="Activity", all.x=T, check.names=F)
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
images.path <- "images/Comp/"

houseA.P1.f <- freq_table_HA_R1
houseA.P1.f <- mutate(houseA.P1.f, Activity=as.character(Activity))
houseA.P2.f <- freq_table_HA_R2
houseA.P2.f <- mutate(houseA.P2.f, Activity=as.character(Activity))
houseB.P1.f <- freq_table_HB_R1
houseB.P1.f <- mutate(houseB.P1.f, Activity=as.character(Activity))
houseB.P2.f <- freq_table_HB_R2
houseB.P2.f <- mutate(houseB.P2.f, Activity=as.character(Activity))

# Comparación de tiempo invertido en tareas de la casa
new.freq <- houseA.P1.f$Freq[houseA.P1.f$Activity=="Preparing Breakfast"][2] +
  houseA.P1.f$Freq[houseA.P1.f$Activity=="Preparing Lunch"][2] +
  houseA.P1.f$Freq[houseA.P1.f$Activity=="Preparing Dinner"][2]
houseA.P1.f <- rbind(houseA.P1.f, list("Cooking", new.freq))

new.freq <- houseA.P1.f$Freq[houseA.P1.f$Activity=="Having Breakfast"][2] + 
  houseA.P1.f$Freq[houseA.P1.f$Activity=="Having Lunch"][2] +
  houseA.P1.f$Freq[houseA.P1.f$Activity=="Having Dinner"][2]
houseA.P1.f <- rbind(houseA.P1.f, list("Eating", new.freq))

new.freq <- houseA.P2.f$Freq[houseA.P2.f$Activity=="Preparing Breakfast"] +
  houseA.P2.f$Freq[houseA.P2.f$Activity=="Preparing Dinner"]
houseA.P2.f <- rbind(houseA.P2.f, list("Cooking", new.freq))

new.freq <- houseA.P2.f$Freq[houseA.P2.f$Activity=="Having Breakfast"] +
  houseA.P2.f$Freq[houseA.P2.f$Activity=="Having Dinner"]
houseA.P2.f <- rbind(houseA.P2.f, list("Eating", new.freq))

new.freq <- houseB.P1.f$Freq[houseB.P1.f$Activity=="Preparing Breakfast"] + 
  houseB.P1.f$Freq[houseB.P1.f$Activity=="Preparing Lunch"] +
  houseB.P1.f$Freq[houseB.P1.f$Activity=="Preparing Dinner"]
houseB.P1.f <- rbind(houseB.P1.f, list("Cooking", new.freq))

new.freq <- houseB.P1.f$Freq[houseB.P1.f$Activity=="Having Breakfast"] + 
  houseB.P1.f$Freq[houseB.P1.f$Activity=="Having Lunch"] 
houseB.P1.f <- rbind(houseB.P1.f, list("Eating", new.freq))

new.freq <- houseB.P2.f$Freq[houseB.P2.f$Activity=="Preparing Breakfast"]
houseB.P2.f <- rbind(houseB.P2.f, list("Cooking", new.freq))

new.freq <- houseB.P2.f$Freq[houseB.P2.f$Activity=="Having Breakfast"]+
  houseB.P2.f$Freq[houseB.P2.f$Activity=="Having Lunch"] +
  houseB.P2.f$Freq[houseB.P2.f$Activity=="Having Dinner"]
houseB.P2.f <- rbind(houseB.P2.f, list("Eating", new.freq))

tareas <- c("Cooking", "Washing Dishes", "Laundry", "Cleaning")           

houseA.tareas <- frec.comp(houseA.P1.f, houseA.P2.f)
houseB.tareas <- frec.comp(houseB.P1.f, houseB.P2.f)

houseA.tareas.m <- mutate(houseA.tareas, P2=-P2)
houseA.tareas.m <- melt(houseA.tareas.m)

names(houseA.tareas.m) <- c("Actividad", "Persona", "Tiempo")

(p <- ggplot(houseA.tareas.m, 
             aes(reorder(Actividad, Tiempo), Tiempo, fill=Persona)) + 
    geom_bar(data=subset(houseA.tareas.m, Persona=="P1"), stat="identity") +
    geom_bar(data=subset(houseA.tareas.m, Persona=="P2"), stat="identity") +
    labs(title = "Time spent in home dutties", x = "") +
    scale_y_continuous(breaks=seq(-600, 1500, 300), 
                       labels=paste(as.character(c(seq(600, 0, -300), 
                                                    seq(300, 1500, 300))), "min")) +
    scale_x_discrete(limit=tareas) +
    coord_flip() + 
    theme_stata() + scale_fill_stata())
ggsave(filename="comparacion_actividades_CasaA.png", 
       plot=p, 
       path=images.path)

houseB.tareas.m <- mutate(houseB.tareas, P2=-P2)
houseB.tareas.m <- melt(houseB.tareas.m)
houseB.tareas.m
names(houseB.tareas.m) <- c("Actividad", "Persona", "Tiempo")
(p <- ggplot(houseB.tareas.m, 
             aes(Actividad, Tiempo, fill=Persona)) + 
    geom_bar(data=subset(houseB.tareas.m, Persona=="P1"), stat="identity") +
    geom_bar(data=subset(houseB.tareas.m, Persona=="P2"), stat="identity") +
    scale_y_continuous(breaks = seq(-600, 600, 100), 
                       labels = paste(as.character(c(seq(600, 0, -100), 
                                                      seq(100, 600, 100))), "min")) +
    scale_x_discrete(limit=tareas) +
    labs(title = "Time spent in home dutties", x="") +
    coord_flip() + 
    theme_stata() + scale_fill_stata())
ggsave(filename="comparacion_actividades_CasaB.png", 
       plot=p, 
       path=images.path)

# Comparación de tiempo invertido en actividades recreativas
rec <- c("Going Out", "Watching TV", "Napping", "Eating","Listening to Music", "Having Guest")           

houseA.rec <- frec.comp(houseA.P1.f, houseA.P2.f)
houseB.rec <- frec.comp(houseB.P1.f, houseB.P2.f)

houseA.rec <- mutate(houseA.rec, P1=P1/60, P2=P2/60)
houseA.rec.m <- mutate(houseA.rec, P2=-P2)
houseA.rec.m <- melt(houseA.rec.m)
names(houseA.rec.m) <- c("Actividad", "Persona", "Tiempo")
(p <- ggplot(houseA.rec.m, 
             aes(Actividad, Tiempo, fill=Persona)) + 
    geom_bar(data=subset(houseA.rec.m, Persona=="P1"), stat="identity") +
    geom_bar(data=subset(houseA.rec.m, Persona=="P2"), stat="identity") +
    labs(title = "Time spento to recreative activities", x = "") +
    scale_y_continuous(breaks = seq(-500, 200, 100), 
                       labels = paste(as.character(c(seq(500, 0, -100), 
                                                      seq(100, 200, 100))), "h")) +
    scale_x_discrete(limit=rec) +
    coord_flip() + 
    theme_stata() + scale_fill_stata())
ggsave(filename="comparacion_recreacion_CasaA.png", 
       plot=p, 
       path=images.path)

houseB.rec <- mutate(houseB.rec, P1=P1/60, P2=P2/60)
houseB.rec.m <- mutate(houseB.rec, P2=-P2)
houseB.rec.m <- melt(houseB.rec.m)
names(houseB.rec.m) <- c("Actividad", "Persona", "Tiempo")
(p <- ggplot(houseB.rec.m, 
             aes(Actividad, Tiempo, fill=Persona)) + 
    geom_bar(data=subset(houseB.rec.m, Persona=="P1"), stat="identity") +
    geom_bar(data=subset(houseB.rec.m, Persona=="P2"), stat="identity") +
    labs(title = "Time spento to recreative activities", x = "") +
    scale_y_continuous(breaks = seq(-800, 300, 75), 
                       labels = paste(as.character(c(seq(800, 0, -75), 
                                                      seq(75, 300, 75))), "h")) +
    scale_x_discrete(limit=rec) +
    coord_flip() + 
    theme_stata() + scale_fill_stata())
ggsave(filename="comparacion_recreacion_CasaB.png", 
       plot=p, 
       path=images.path)

setwd(repo.dir)
