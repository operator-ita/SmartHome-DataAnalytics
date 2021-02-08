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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    library(ggplot2)
    
    #Gráfico de Histograma
    output$plot1 <- renderPlot({
        
        x <- mtcars[,input$x]
        bin <- seq(min(x), max(x), length.out = input$bins + 1)
        
        ggplot(mtcars, aes(x, fill = mtcars[,input$zz])) + 
            geom_histogram( breaks = bin) +
            labs( xlim = c(0, max(x))) + 
            theme_light() + 
            xlab(input$x) + ylab("Frecuencia") + 
            facet_grid(input$zz)
        
        
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
    output$data_table <- renderDataTable( {mtcars}, 
                                          options = list(aLengthMenu = c(5,25,50),
                                                         iDisplayLength = 5)
    )
})
