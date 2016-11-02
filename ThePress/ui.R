library(rsconnect)
library(shinyapps)
library(shiny)
library(NLP)
library(tm)
library(RColorBrewer)
library(wordcloud)

shinyUI(
  fluidPage(
    titlePanel("Comparando Medios"),
  
    sidebarLayout(
      
      sidebarPanel(
        
        actionButton('goPlot', 'Go plot'),
        
        dateInput("date", label = h2("Ingrese Fecha"), value = "2016-10-10"),
        
        selectInput("Fuente", "Elegir Fuente:",
                    choices = c("EMOL", "LA TERCERA", "DF")),
        

        selectInput("Color", "Choose a colour palette:",
                    choices = c("Accent", "Dark2", "Paired", "Pastel1", "Pastel2", "Set1", "Set2", "Set3")),
        
        ## actionButton("update", "Change"),
        
        selectInput("Font", "Choose the font Face:",
                    choices = c("plain", "bold", "italic")),
        
        selectInput("Family", "Choose the Font Family:",
                    choices = c("serif", "script")),
        
        sliderInput("Words",
                    "Max words:",
                    min = 1,
                    max = 50,
                    value = 30)
                    ),
      
        
   
      
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("Plot")
    )
  )
))
