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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    library(ggplot2)
    
    #Gráfico de Histograma
    output$plot1 <- renderPlot({
        
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
