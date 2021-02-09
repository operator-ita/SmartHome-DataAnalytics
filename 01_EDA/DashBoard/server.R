#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(shinythemes)
library(ggplot2)
library(scales)
library(reshape2)
library(dplyr)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    library(ggplot2)
    library(ggthemes)
    
    # Bar Charts
    # Loading and cleaning the frequency tables
    freq_table_HA_R1 <- read.csv('Freq_houseA_P1.csv')
    freq_table_HA_R1[1,2] <- "Going_Out"
    freq_table_HA_R1[2,2] <- "Missing_Activity"
    names(freq_table_HA_R1)[2] <- "Activity"
    
    freq_table_HA_R2 <- read.csv('Freq_houseA_P2.csv')
    freq_table_HA_R2[1,2] <- "Going_Out"
    freq_table_HA_R2[2,2] <- "Missing_Activity"
    names(freq_table_HA_R2)[2] <- "Activity"
    
    freq_table_HB_R1 <- read.csv('Freq_houseB_P1.csv')
    freq_table_HB_R1[1,2] <- "Missing Activity"
    names(freq_table_HB_R1)[2] <- "Activity"
    
    freq_table_HB_R2 <- read.csv('Freq_houseB_P2.csv')
    freq_table_HB_R2[1,2] <- "Missing Activity"
    names(freq_table_HB_R2)[2] <- "Activity"
    
    # Creation of charts
    # Sorting Frequencies
    freq_table_HA_R1[order(freq_table_HA_R1$Freq, decreasing = TRUE),]    
    freq_table_HA_R2[order(freq_table_HA_R2$Freq, decreasing = TRUE),]
    freq_table_HB_R1[order(freq_table_HB_R1$Freq, decreasing = TRUE),]
    freq_table_HB_R2[order(freq_table_HB_R2$Freq, decreasing = TRUE),]
    
    #Grfico de Histograma
    output$plot1 <- renderPlot({
        if (input$casa == "Casa A" & input$persona == "P1"){
            opcion = freq_table_HA_R1
        } else if (input$casa == "Casa A" & input$persona == "P2") {
            opcion = freq_table_HA_R2
        } else if (input$casa == "Casa B" & input$persona == "P1") {
            opcion = freq_table_HB_R1
        } else if (input$casa == "Casa B" & input$persona == "P2") {
            opcion = freq_table_HB_R2
        }
        
        # Creation of bar charts
        ggplot(data = opcion, aes(x = reorder(Activity, Freq), y = Freq)) +
            geom_col(aes(fill = Activity) , show.legend = FALSE) +
            coord_flip() +
            geom_label(aes(label = percent(Freq/sum(Freq), accuracy =  0.001),
                           y = -150, fill = Activity),
                       show.legend = FALSE,
                       size = 3.5, label.padding = unit(0.1, "lines")) +
            expand_limits(y = -150)+
            labs(x = "Activity", y = "Seconds")
    })
    
    output$plot_P1vsP2_act <- renderPlot({
        if (input$casa2 == "Casa A" & input$tipoAct == "Deberes"){
            HA_Duties
        } else if (input$casa2 == "Casa A" & input$tipoAct == "Recreativas") {
            HA_Recreativo
        } else if (input$casa2 == "Casa B" & input$tipoAct == "Deberes") {
            HB_Duties
        } else if (input$casa2 == "Casa B" & input$tipoAct == "Recreativas") {
            HB_Recreativo
        }
    })
    
    houseA.P1.f <- read.csv("houseA_P1.csv")
    houseA.P1.f <- mutate(houseA.P1.f, Var1=as.character(Var1))
    houseA.P2.f <- read.csv("houseA_P2.csv")
    houseA.P2.f <- mutate(houseA.P2.f, Var1=as.character(Var1))
    houseB.P1.f <- read.csv("houseB_P1.csv")
    houseB.P1.f <- mutate(houseB.P1.f, Var1=as.character(Var1))
    houseB.P2.f <- read.csv("houseB_P2.csv")
    houseB.P2.f <- mutate(houseB.P2.f, Var1=as.character(Var1))
    
    # Comparacion de tiempo invertido en tareas de la casa
    new.freq <- houseA.P1.f$Freq[houseA.P1.f$Var1=="Preparing Breakfast"][2] +
        houseA.P1.f$Freq[houseA.P1.f$Var1=="Preparing Lunch"][2] +
        houseA.P1.f$Freq[houseA.P1.f$Var1=="Preparing Dinner"][2]
    houseA.P1.f <- rbind(houseA.P1.f, list("Cooking", new.freq))
    
    new.freq <- houseA.P1.f$Freq[houseA.P1.f$Var1=="Having Breakfast"][2] + 
        houseA.P1.f$Freq[houseA.P1.f$Var1=="Having Lunch"][2] +
        houseA.P1.f$Freq[houseA.P1.f$Var1=="Having Dinner"][2]
    houseA.P1.f <- rbind(houseA.P1.f, list("Eating", new.freq))
    
    new.freq <- houseA.P2.f$Freq[houseA.P2.f$Var1=="Preparing Breakfast"] +
        houseA.P2.f$Freq[houseA.P2.f$Var1=="Preparing Dinner"]
    houseA.P2.f <- rbind(houseA.P2.f, list("Cooking", new.freq))
    
    new.freq <- houseA.P2.f$Freq[houseA.P2.f$Var1=="Having Breakfast"] +
        houseA.P2.f$Freq[houseA.P2.f$Var1=="Having Dinner"]
    houseA.P2.f <- rbind(houseA.P2.f, list("Eating", new.freq))
    
    new.freq <- houseB.P1.f$Freq[houseB.P1.f$Var1=="Preparing Breakfast"] + 
        houseB.P1.f$Freq[houseB.P1.f$Var1=="Preparing Lunch"] +
        houseB.P1.f$Freq[houseB.P1.f$Var1=="Preparing Dinner"]
    houseB.P1.f <- rbind(houseB.P1.f, list("Cooking", new.freq))
    
    new.freq <- houseB.P1.f$Freq[houseB.P1.f$Var1=="Having Breakfast"] + 
        houseB.P1.f$Freq[houseB.P1.f$Var1=="Having Lunch"] 
    houseB.P1.f <- rbind(houseB.P1.f, list("Eating", new.freq))
    
    new.freq <- houseB.P2.f$Freq[houseB.P2.f$Var1=="Preparing Breakfast"]
    houseB.P2.f <- rbind(houseB.P2.f, list("Cooking", new.freq))
    
    new.freq <- houseB.P2.f$Freq[houseB.P2.f$Var1=="Having Breakfast"]+
        houseB.P2.f$Freq[houseB.P2.f$Var1=="Having Lunch"] +
        houseB.P2.f$Freq[houseB.P2.f$Var1=="Having Dinner"]
    houseB.P2.f <- rbind(houseB.P2.f, list("Eating", new.freq))
    
    tareas <- c("Cooking", "Washing Dishes", "Laundry", "Cleaning")           
    
    houseA.tareas <- merge(houseA.P1.f, houseA.P2.f, by="Var1", all.x=T, check.names=F)
    names(houseA.tareas) <- c("Activity", "P1", "P2")
    houseA.tareas[is.na(houseA.tareas)] <- 0
    houseA.tareas <- mutate(houseA.tareas, P1=P1/60, P2=P2/60)
    
    houseB.tareas <- merge(houseB.P1.f, houseB.P2.f, by="Var1", all.x=T, check.names=F)
    names(houseB.tareas) <- c("Activity", "P1", "P2")
    houseB.tareas[is.na(houseB.tareas)] <- 0
    houseB.tareas <- mutate(houseB.tareas, P1=P1/60, P2=P2/60)
    
    houseA.tareas.m <- mutate(houseA.tareas, P2=-P2)
    houseA.tareas.m <- melt(houseA.tareas.m)
    houseB.tareas.m <- mutate(houseB.tareas, P2=-P2)
    houseB.tareas.m <- melt(houseB.tareas.m)
    
    names(houseA.tareas.m) <- c("Actividad", "Persona", "Tiempo")
    names(houseB.tareas.m) <- c("Actividad", "Persona", "Tiempo")
    HA_Duties <- ggplot(houseA.tareas.m, 
                         aes(reorder(Actividad, Tiempo), Tiempo, fill=Persona)) + 
            geom_bar(data=subset(houseA.tareas.m, Persona=="P1"), stat="identity") +
            geom_bar(data=subset(houseA.tareas.m, Persona=="P2"), stat="identity") +
            labs(x = "") +
            scale_y_continuous(breaks=seq(-600, 1500, 300), 
                               labels=paste(as.character(c(seq(600, 0, -300), 
                                                           seq(300, 1500, 300))), "min")) +
            scale_x_discrete(limit=tareas) +
            coord_flip() + 
        theme_stata() + scale_fill_stata()
    
    HB_Duties <- ggplot(houseB.tareas.m, 
                        aes(reorder(Actividad, Tiempo), Tiempo, fill=Persona)) + 
        geom_bar(data=subset(houseB.tareas.m, Persona=="P1"), stat="identity") +
        geom_bar(data=subset(houseB.tareas.m, Persona=="P2"), stat="identity") +
        labs(x = "") +
        scale_y_continuous(breaks=seq(-600, 1500, 300), 
                           labels=paste(as.character(c(seq(600, 0, -300), 
                                                       seq(300, 1500, 300))), "min")) +
        scale_x_discrete(limit=tareas) +
        coord_flip() + 
        theme_stata() + scale_fill_stata()
        
        names(houseB.tareas.m) <- c("Actividad", "Persona", "Tiempo")
        HB_Duties <- ggplot(houseB.tareas.m, 
                     aes(Actividad, Tiempo, fill=Persona)) + 
                geom_bar(data=subset(houseB.tareas.m, Persona=="P1"), stat="identity") +
                geom_bar(data=subset(houseB.tareas.m, Persona=="P2"), stat="identity") +
                scale_y_continuous(breaks = seq(-600, 600, 100), 
                                   labels = paste(as.character(c(seq(600, 0, -100), 
                                                                 seq(100, 600, 100))), "min")) +
                scale_x_discrete(limit=tareas) +
                labs(title = "Time spent in home dutties", x="") +
                coord_flip() + 
                theme_stata() + scale_fill_stata()
        
        # Comparacion de tiempo invertido en actividades recreativas
        #           
        
        rec <- c("Going Out", "Watching TV", "Napping", "Eating","Listening to Music", "Having Guest")           
        
        houseA.rec <- merge(houseA.P1.f, houseA.P2.f, by="Var1", all.x=T, check.names=F)
        names(houseA.rec) <- c("Activity", "P1", "P2")
        houseA.rec[is.na(houseA.rec)] <- 0
        houseA.rec <- mutate(houseA.rec, P1=P1/60, P2=P2/60)
        
        houseB.rec <- merge(houseB.P1.f, houseB.P2.f, by="Var1", all.x=T, check.names=F)
        names(houseB.rec) <- c("Activity", "P1", "P2")
        houseB.rec[is.na(houseB.rec)] <- 0
        houseB.rec <- mutate(houseB.rec, P1=P1/60, P2=P2/60)
        
        houseA.rec <- mutate(houseA.rec, P1=P1/60, P2=P2/60)
        houseA.rec.m <- mutate(houseA.rec, P2=-P2)
        houseA.rec.m <- melt(houseA.rec.m)
        names(houseA.rec.m) <- c("Actividad", "Persona", "Tiempo")
        HA_Recreativo <- ggplot(houseA.rec.m, 
                     aes(Actividad, Tiempo, fill=Persona)) + 
                geom_bar(data=subset(houseA.rec.m, Persona=="P1"), stat="identity") +
                geom_bar(data=subset(houseA.rec.m, Persona=="P2"), stat="identity") +
                labs(x = "") +
                scale_y_continuous(breaks = seq(-500, 200, 100), 
                                   labels = paste(as.character(c(seq(500, 0, -100), 
                                                         seq(100, 200, 100))), "h")) +
                scale_x_discrete(limit=rec) +
                coord_flip() + 
                theme_stata() + scale_fill_stata()
        
        houseB.rec <- mutate(houseB.rec, P1=P1/60, P2=P2/60)
        houseB.rec.m <- mutate(houseB.rec, P2=-P2)
        houseB.rec.m <- melt(houseB.rec.m)
        names(houseB.rec.m) <- c("Actividad", "Persona", "Tiempo")
        HB_Recreativo <- ggplot(houseB.rec.m, 
                     aes(Actividad, Tiempo, fill=Persona)) + 
                geom_bar(data=subset(houseB.rec.m, Persona=="P1"), stat="identity") +
                geom_bar(data=subset(houseB.rec.m, Persona=="P2"), stat="identity") +
                labs(x = "") +
                scale_y_continuous(breaks = seq(-800, 300, 75), 
                           labels = paste(as.character(c(seq(800, 0, -75), 
                                                         seq(75, 300, 75))), "h")) +
                scale_x_discrete(limit=rec) +
                coord_flip() + 
                theme_stata() + scale_fill_stata()
    
    # Gráficas de dispersión
    output$output_plot <- renderPlot({ 
        
        ggplot(mtcars, aes(x =  mtcars[,input$a] , y = mtcars[,input$y], 
                           colour = mtcars[,input$z] )) + 
            geom_point() +
            ylab(input$y) +
            xlab(input$a) + 
            theme_linedraw() + 
            facet_grid(input$z)  #selección del grid
        
    })   
    
    #Data Table
    output$act_type <- renderDataTable( {mtcars}, 
                                          options = list(aLengthMenu = c(5,25,50),
                                                         iDisplayLength = 5)
    )
})
