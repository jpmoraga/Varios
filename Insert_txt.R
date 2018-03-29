library(openxlsx)


db <- read.xlsx('X:/Analytics/Ripley/Dashboard/1a Base Competencia/Base_Inversion_Ripley.xlsx', sheet = 1)

x1 <- NULL
for(i in 1:length(colnames(db))) {
  
  c <- colnames(db)[i]
  x1 <- ifelse(i == 1,c,paste(x1,c,sep = ','))
}

x3 <- NULL
for(j in 1:nrow(db)) {
#for(j in 1:1000) {
  x2 <- NULL
  for(i in 1:length(colnames(db))) {
    
    c1 <- as.character(db[j,][i])
    x2 <- ifelse(i == 1,paste0("'",c1),paste(x2,c1,sep = "','"))
  }
  x2 <- paste0(x2,"'")

  x <- paste0('INSERT INTO ','dbo.basesRipley (',x1,')',' VALUES(',x2,')')
  x3 <- rbind(x3,x)
  print(j)
}


dir.create('X:/Analytics/Ripley/Dashboard/INSERTS')
for(k in 1:round(dim(x3)[1]/4000,0) + 1) {
#for(k in 1:10) {
  write.table(x3[(4000*(k-1)+1):(4000*k)], paste0('X:/Analytics/Ripley/Dashboard/INSERTS/INSERT',k,'.txt'), sep='\t', row.names = FALSE, col.names = FALSE, quote = FALSE)  
}


write.table(x3, 'X:/Analytics/Ripley/Dashboard/INSERTS/INSERT.txt', sep='\t', row.names = FALSE, col.names = FALSE, quote = FALSE)
