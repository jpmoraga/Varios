library(rsconnect)
library(devtools)
library(digest)
library(shinyapps)
library(shiny)
library(NLP)
library(tm)
library(RColorBrewer)
library(wordcloud)
library(plyr)
## rsconnect::deployApp("C:/Users/jmoraga/Desktop/ShinyApps/ThePress1")
shinyServer(
  function(input, output) {
    
    output$Plot <- renderPlot({
      
      
      
      ############################### Load the data #######################################
      NC <- read.csv("newsCorpora.csv", header = FALSE, sep = "\t")
      
      
      names(NC) <- c("ID","TITLE", "URL", "PUBLISHER", "CATEGORY", "STORY", "HOSTNAME", "TIMESTAMP")
      
      
      T <- NC[NC$PUBLISHER %in% c("Reuters", "Huffington Post", "Businessweek", "Daily Mail", "Contactmusic.com", "NASDAQ"),c("ID","TITLE","PUBLISHER", "CATEGORY", "TIMESTAMP")]
      
      
      T$TIMESTAMP <- as.Date(as.POSIXct(T$TIMESTAMP/1000, origin = "1970-01-01"))
      ##################################################################################
      
      
      T1 <- T[as.Date(T$TIMESTAMP,"%Y-%m-%d") == input$date & T$PUBLISHER == input$Publisher, ]
      
      
      T2 <- as.vector(T1$TITLE)
      
      t_corp <- VCorpus(VectorSource(T2))
      
      t_corp1 <- tm_map(t_corp,removePunctuation)
      
      t_corp2 <- tm_map(t_corp1, removeNumbers)
      
      t_corp3 <- tm_map(t_corp2, content_transformer(tolower)) 
      
      t_corp4 <- tm_map(t_corp3,removeWords, c(stopwords("en"), "update"))
      
      t_corp5 <- TermDocumentMatrix(t_corp4)
      
      m <- as.matrix(t_corp5)
      
      v <- sort(rowSums(m),decreasing=TRUE)
      
      DF <- data.frame(word = names(v),freq=v)
      
      DF$Len <- nchar(as.vector(row.names(DF)))
      
      Words <- subset(DF, Len < 20 & Len > 3, -Len)
      ##x <- colnames(airquality)
      
      wordcloud(row.names(Words), freq = v, scale=c(5,.6), min.freq = 3, max.words = input$Words, colors = brewer.pal(8,input$Color), random.order=FALSE, vfont = c(input$Family,input$Font), rot.per=.3)
      ##wordcloud(row.names(Words), freq = v, max.words = 30, colors = brewer.pal(8,"Accent"), random.order=FALSE, vfont = c("serif","plain"), rot.per=.3)
      
      
        
                                  })
                            }
            )