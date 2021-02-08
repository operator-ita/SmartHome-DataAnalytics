#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    dashboardPage(
        
        skin = "purple",
        
        dashboardHeader(title = "Equipo 14 - Domotica"),
        
        dashboardSidebar(
            
            sidebarMenu(
                menuItem("Overview", tabName = "Overview", icon = icon("dashboard")),
                menuItem("Series de tiempo", tabName = "timeseries", icon = icon("area-chart")),
                menuItem("Tipo de Actividad", tabName = "data_table", icon = icon("table")),
                menuItem("Misc", tabName = "img", icon = icon("file-picture-o"))
            )
            
        ),
        
        dashboardBody(
            
            tabItems(
                
                # Histograma
                tabItem(tabName = "Overview",
                        fluidRow(
                            titlePanel("Histograma de las variables del data set mtcars"), 
                            selectInput("x", "Seleccione el valor de X",
                                        choices = names(mtcars)),
                            
                            selectInput("zz", "Selecciona la variable del grid", 
                                        
                                        choices = c("cyl", "vs", "gear", "carb")),
                            box(plotOutput("plot1", height = 250)),
                            
                            box(
                                title = "Controls",
                                sliderInput("bins", "Number of observations:", 1, 30, 15)
                            )
                        )
                ),
                
                # Dispersión
                tabItem(tabName = "timeseries", 
                        fluidRow(
                            titlePanel(h3("Gráficos de dispersión")),
                            selectInput("a", "Selecciona el valor de x",
                                        choices = names(mtcars)),
                            selectInput("y", "Seleccione el valor de y",
                                        choices = names(mtcars)),
                            selectInput("z", "Selecciona la variable del grid", 
                                        choices = c("cyl", "vs", "gear", "carb")),
                            box(plotOutput("output_plot", height = 300, width = 460) )
                            
                        )
                ),
                
                
                
                tabItem(tabName = "data_table",
                        fluidRow(        
                            titlePanel(h3("Data Table")),
                            dataTableOutput ("data_table")
                        )
                ), 
                
                tabItem(tabName = "img",
                        fluidRow(
                            titlePanel(h3("Imágen de calor para la correlación de las variables")),
                            img( src = "cor_mtcars.png", 
                                 height = 350, width = 350)
                        )
                )
                
            )
        )
    )
))
