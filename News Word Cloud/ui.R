library(rsconnect)
library(shinyapps)
library(shiny)
library(NLP)
library(tm)
library(RColorBrewer)
library(wordcloud)
library(plyr)

shinyUI(
  fluidPage(
    titlePanel("News"),
  
    sidebarLayout(
      
      sidebarPanel(
        
        dateInput("date", label = h2("Input Date"), value = "2014-03-10"),
        
        selectInput("Publisher", "Select Publisher:",
                    choices = c("Reuters", "Huffington Post", "Businessweek", "Daily Mail", "Contactmusic.com", "NASDAQ")),
        

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
       
   
    
 
    # Show a plot of the wordcloud
    mainPanel(
      plotOutput("Plot")
    )
  )
)
)
