library(RJSONIO)
library(readtext)

setwd('C:/Users/juanpablo.moraga/Desktop/CCU/Datapoint')
json_file <- '_Test_facebook.adsinsight-2018-02-26T20-44-53.6Z-513486576d2f45359eb5f68cbb7e07d0.txt'

json <- readtext(json_file)

json <- fromJSON(json[,2])

json <- json$insights$insights_data$data


for(i in 1:length(json)) {
  
  json1 <- as.data.frame(json[1])
  
  for(j in 1:dim(json1)[2]) {
    
    if(json1[1,j] != json1[2,j]) {
      colnames(json1)[j] <- as.character(json1[,j][1])
      
    } else {
      colnames(json1)[j] <- colnames(json1)[j]
    }
  }
  
  json1 <- json1[2,]
  
}



names <- names(json)
vec <- names == 'account_id'
filter <- which(vec == TRUE)



m <- matrix(NA,length(filter),146)

for(i in 2:length(filter)) {
  m[i-1,] <- c(names[filter[i-1]:(filter[i]-1)],rep(0,146-length(names[filter[i-1]:(filter[i]-1)])))
}

#Seleccionar nombres
