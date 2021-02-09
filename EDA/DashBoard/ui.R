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
                menuItem("Tipo de Actividad", tabName = "act_type", icon = icon("table")),
                menuItem("Misc", tabName = "img", icon = icon("file-picture-o"))
            )
            
        ),
        
        dashboardBody(
            
            tabItems(
                
                # Overview
                tabItem(tabName = "Overview",
                        fluidRow(
                            titlePanel("Informacion basica de actividades por persona"), 
                            selectInput("casa", "Seleccione la casa",
                                        choices = c("Casa A", "Casa B")),
                            selectInput("persona", "Selecciona la persona", 
                                        choices = c("P1", "P2")),
                            box(plotOutput("plot1", height = 370, width = 1000)),
                        ),
                        fluidRow(
                            titlePanel("Comparacion de actividades"),
                            selectInput("casa2", "Selecciona la casa", choices = 
                                            c("Casa A", "Casa B")),
                            selectInput("tipoAct", "Selecciona la tarea", choices =
                                            c("Deberes", "Recreativas")),
                            box(plotOutput("plot_P1vsP2_act"))
                        )
                ),
                
                # Series de tiempo
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
                
                
                
                tabItem(tabName = "act_type",
                        fluidRow(        
                            titlePanel(h3("Data Table")),
                            dataTableOutput ("act_type")
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
