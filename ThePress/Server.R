library(rsconnect)
library(devtools)
library(digest)
library(shinyapps)
library(shiny)
library(NLP)
library(tm)
library(RColorBrewer)
library(wordcloud)
## rsconnect::deployApp("C:/Users/jmoraga/Desktop/ShinyApps/ThePress")
shinyServer(
  function(input, output) {
    
    output$Plot <- renderPlot({
      
      input$goPlot
      
      ############################### desde txt #######################################
      t <- readLines("Noticias3.txt", encoding = "UTF-8")
      t <- t[2:length(t)] ## t[80613:91889]
      t <- strsplit(t,"|",fixed = TRUE)
      x <- function(y) {y[2:6]}
      t <- lapply(t,x)
      t <- as.data.frame(do.call(rbind,t))
      t$V6 <- strptime(t$V3,"%Y-%m-%d")
      colnames(t) <- c("Id","Fuente","Fecha_Registro","Seccion","Titulo","Fecha_Dia")
      t <- t[-c(181,1200),]
      ##################################################################################
      
      ##t1 <- t[t$Fecha_Dia == "2016-10-05" & t$Fuente == "DF",]
      t1 <- t[as.Date(t$Fecha_Dia,"%Y-%m-%d") == input$date & t$Fuente == input$Fuente, ]
      ##t1 <- t
      
      t2 <- as.vector(t1$Titulo)
      
      t_corp <- VCorpus(VectorSource(t2))
      
      t_corp1 <- tm_map(t_corp,removePunctuation)
      
      t_corp2 <- tm_map(t_corp1, removeNumbers)
      
      t_corp3 <- tm_map(t_corp2, content_transformer(tolower)) 
      
      t_corp4 <- tm_map(t_corp3,removeWords, c(stopwords("es"),"emolcom","tras","chile","anos","ano"))
      
      t_corp5 <- TermDocumentMatrix(t_corp4)
      
      m <- as.matrix(t_corp5)
      
      v <- sort(rowSums(m),decreasing=TRUE)
      
      DF <- data.frame(word = names(v),freq=v)
      
      DF$Len <- nchar(as.vector(row.names(DF)))
      
      Words <- subset(DF, Len < 20 & Len > 3, -Len)
      ##x <- colnames(airquality)
      
      wordcloud(row.names(Words), freq = v, scale=c(5,.6), min.freq = 4, max.words = input$Words, colors = brewer.pal(8,input$Color), random.order=FALSE, vfont = c(input$Family,input$Font), rot.per=.3)
      ##wordcloud(row.names(Words), freq = v, max.words = 30, colors = brewer.pal(8,"Accent"), random.order=FALSE, vfont = c("serif","plain"), rot.per=.3)
      
        
                                  })
                            }
            )