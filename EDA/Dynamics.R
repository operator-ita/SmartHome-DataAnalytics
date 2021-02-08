# @Proyecto: Predicción de comportamiento en una casa inteligente
# @Equipo: 14

# Comparación de la dinámica de cada casa:

# Librerías
library(dplyr)
library(ggplot2)
library(plyr)
library(reshape2)
library(ggthemes)

# Directorio de trabajo
repo.dir <- "C:/Users/luisf/Documents/Github/SmartHome-DataAnalytics"
setwd(repo.dir)

# Funciones
frec.comp <- function(df1, df2, act.vec){
  #new.df <- merge(filter(df1, Var1 %in% act.vec),
  #                filter(df2, Var1 %in% act.vec), 
  #                by="Var1", all.x=T, chek.names=F)
  new.df <- merge(df1, df2, by="Var1", all.x=T, check.names=F)
  new.df <- new.df[, c(1,3,5)]
  names(new.df) <- c("Activity", "P1", "P2")
  new.df[is.na(new.df)] <- 0
  new.df <- mutate(new.df, P1=P1/60, P2=P2/60)

  return(new.df)
}

images.path <- "EDA/img"
# Importación de datasets 
(houseA.P1.f <- read.csv("data/Frequency/Freq_houseA_P1.csv"))
houseA.P2.f <- read.csv("data/Frequency/Freq_houseA_P2.csv")
houseB.P1.f <- read.csv("data/Frequency/Freq_houseB_P1.csv")
houseB.P2.f <- read.csv("data/Frequency/Freq_houseB_P2.csv")

# Comparación de tiempo invertido en tareas de la casa
houseA.P1.f <- rbind(houseA.P1.f, list(28, "Cooking", houseA.P1.f$Freq[houseA.P1.f$Var1=="Preparing_Breakfast"] + 
                          houseA.P1.f$Freq[houseA.P1.f$Var1=="Preparing_Lunch"] +
                          houseA.P1.f$Freq[houseA.P1.f$Var1=="Preparing_Dinner"]))
houseA.P1.f <- rbind(houseA.P1.f, list(29, "Eating", houseA.P1.f$Freq[houseA.P1.f$Var1=="Having_Breakfast"] + 
                                         houseA.P1.f$Freq[houseA.P1.f$Var1=="Having_Lunch"] +
                                         houseA.P1.f$Freq[houseA.P1.f$Var1=="Having_Dinner"]))
houseA.P2.f <- rbind(houseA.P2.f, list(25, "Cooking", houseA.P2.f$Freq[houseA.P2.f$Var1=="Preparing_Breakfast"] +
                                         houseA.P2.f$Freq[houseA.P2.f$Var1=="Preparing_Dinner"]))
houseA.P2.f <- rbind(houseA.P2.f, list(26, "Eating", houseA.P2.f$Freq[houseA.P2.f$Var1=="Having_Breakfast"] +
                                         houseA.P2.f$Freq[houseA.P2.f$Var1=="Having_Dinner"]))
houseB.P1.f <- rbind(houseB.P1.f, list(28, "Cooking", houseB.P1.f$Freq[houseB.P1.f$Var1=="Preparing Breakfast"] + 
                                         houseB.P1.f$Freq[houseB.P1.f$Var1=="Preparing Lunch"] +
                                         houseB.P1.f$Freq[houseB.P1.f$Var1=="Preparing Dinner"]))
houseB.P1.f <- rbind(houseB.P1.f, list(29, "Eating", houseB.P1.f$Freq[houseB.P1.f$Var1=="Having Breakfast"] + 
                                         houseB.P1.f$Freq[houseB.P1.f$Var1=="Having Lunch"]))
houseB.P2.f <- rbind(houseB.P2.f, list(25, "Cooking", houseB.P2.f$Freq[houseB.P2.f$Var1=="Preparing Breakfast"]))
houseB.P2.f <- rbind(houseB.P2.f, list(26, "Eating", houseB.P2.f$Freq[houseB.P2.f$Var1=="Having Breakfast"]+
                                         houseB.P2.f$Freq[houseB.P2.f$Var1=="Having Lunch"] +
                                         houseB.P2.f$Freq[houseB.P2.f$Var1=="Having Dinner"]))

hA.t <- c("Cooking", "Washing_Dishes", "Laundry", "Cleaning")           
hB.t <- c("Cooking", "Washing Dishes", "Laundry", "Cleaning") 
houseA.tareas <- frec.comp(houseA.P1.f, houseA.P2.f)
houseB.tareas <- frec.comp(houseB.P1.f, houseB.P2.f)

houseA.tareas.m <- mutate(houseA.tareas, P2=-P2)
houseA.tareas.m <- melt(houseA.tareas.m)
names(houseA.tareas.m) <- c("Actividad", "Persona", "Tiempo")
(p <- ggplot(houseA.tareas.m, 
            aes(Actividad, Tiempo, fill=Persona)) + 
  geom_bar(data=subset(houseA.tareas.m, Persona=="P1"), stat="identity") +
  geom_bar(data=subset(houseA.tareas.m, Persona=="P2"), stat="identity") +
  labs(title = "Tiempo dedicado a deberes domésticos", x = "") +
  scale_y_continuous(breaks=seq(-600, 1500, 300), 
                     labels=paste0(as.character(c(seq(600, 0, -300), 
                                                    seq(300, 1500, 300))), "min")) +
  scale_x_discrete(limit=hA.t, 
                   labels=c("Cocina", "Platos", "Lavandería", "Limpieza")) +
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
                     labels = paste0(as.character(c(seq(600, 0, -100), 
                                                    seq(100, 600, 100))), "min")) +
  scale_x_discrete(limit=hB.t,
                   labels=c("Cocina", "Platos", "Lavandería", "Limpieza")) +
  labs(title = "Tiempo dedicado a deberes domésticos", x="") +
  coord_flip() + 
  theme_stata() + scale_fill_stata())
ggsave(filename="comparacion_actividades_CasaB.png", 
       plot=p, 
       path=images.path)

# Comparación de tiempo invertido en actividades recreativas
hA.r <- c("Watching_TV", "Napping", "Eating","Listening_to_Music", "Having_Guest")           
hB.r <- c("Going Out", "Watching TV", "Eating")
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
  labs(title = "Tiempo dedicado a actividades de recreación", x = "") +
  scale_y_continuous(breaks = seq(-100, 200, 25), 
                     labels = paste0(as.character(c(seq(100, 0, -25), 
                                                    seq(25, 200, 25))), "h")) +
  scale_x_discrete(limit=hA.r, 
                   labels=c("TV", "Siesta", "Comer", "Música", "Invitados")) +
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
  labs(title = "Tiempo dedicado a actividades de recreación", x = "") +
  scale_y_continuous(breaks = seq(-400, 300, 75), 
                     labels = paste0(as.character(c(seq(400, 0, -75), 
                                                    seq(75, 300, 75))), "h")) +
  scale_x_discrete(limit=hB.r, 
                   labels=c("Salir", "TV", "Comer")) +
  coord_flip() + 
  theme_stata() + scale_fill_stata())
ggsave(filename="comparacion_recreacion_CasaB.png", 
       plot=p, 
       path=images.path)
