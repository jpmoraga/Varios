################################## BASES CSV ######################################
setwd("C:/Users/JP/Desktop/Mails Guga/Bases_CSV")
x <- list.files()

c <- c("jp.moraga.leigh@gmail.com")
c <- as.data.frame(c)
c <- setNames(object = c, "Mail")

b <- c(NULL,NULL,NULL)


for(i in 1:length(x))
{
  a1 <- read.csv(x[i],header=FALSE)
  a1 <- unname(a1, force = FALSE)
  a1 <- setNames(object = a1, "Mail")
  a1 <- gsub(" ","",a1$Mail)
  a1 <- na.omit(a1)
  a1 <- as.data.frame(a1)
  a1 <- setNames(object = a1, "Mail")
  
  a1 <- na.omit(sapply(a1,Mail_Valido))
  
  a1 <- as.data.frame(a1)
  
  c <- unique(rbind(c,a1))
  
  i = i + 1
}

################################## BASES TXT ######################################

setwd("C:/Users/JP/Desktop/Mails Guga/Bases_TXT")
x <- list.files()

t <- c("jp.moraga.leigh@gmail.com")
t <- as.data.frame(t)
t <- setNames(object = t, "Mail")

b <- c(NULL,NULL,NULL)


for(i in 1:length(x))
{
  a1 <- read.table(x[i],header=FALSE)
  a1 <- unname(a1, force = FALSE)
  a1 <- setNames(object = a1, "Mail")
  a1 <- gsub(" ","",a1$Mail)
  a1 <- na.omit(a1)
  a1 <- as.data.frame(a1)
  a1 <- setNames(object = a1, "Mail")
  
  a1 <- na.omit(sapply(a1,Mail_Valido))
  
  a1 <- as.data.frame(a1)
  
  t <- unique(rbind(t,a1))
  
  i = i + 1
}

################################## CONSOLIDADO ######################################

z <- unique(rbind(c,t))
##z <- na.omit(sapply(z,Mail_Valido))

remove(c)
remove(t)


z1 <- z[grep("@gmail.com",z$Mail),] ## gmail
z2 <- z[grep("@hotmail.com",z$Mail),] ## hotmail
z3 <- z[grep("@yahoo.com",z$Mail),] ## yahoo.com
z4 <- z[grep("@yahoo.es",z$Mail),] ## yahoo.es
z5 <- z[grep("@uai.cl",z$Mail),] ## uai
z6 <- z[grep("@uandes.cl",z$Mail),] ## uandes
z7 <- z[grep("@entelchile.net",z$Mail),] ## EntelChile
z8 <- z[grep("@vtr.net",z$Mail),] ## vtr

z1 <- setNames(object = as.data.frame(z1), "Mail")
z2 <- setNames(object = as.data.frame(z2), "Mail")
z3 <- setNames(object = as.data.frame(z3), "Mail")
z4 <- setNames(object = as.data.frame(z4), "Mail")
z5 <- setNames(object = as.data.frame(z5), "Mail")
z6 <- setNames(object = as.data.frame(z6), "Mail")
z7 <- setNames(object = as.data.frame(z7), "Mail")
z8 <- setNames(object = as.data.frame(z8), "Mail")

zz <- rbind(z1,z3,z4,z5,z6,z7,z8,z2)
zz <- unname(zz, force = FALSE)
s <- seq(1, nrow(zz), by = 20000)


zz <- as.vector(zz)

setwd("C:/Users/JP/Desktop/Mails Guga/Envios")

for(i in 1:(length(s)-1))
{
  write.csv(zz[s[i]:s[i + 1],], file = paste("Envio",i,sep = "_"),row.names=FALSE,col.names=FALSE,quote = FALSE)
  
  i = i + 1
}

z9 <- z[grep("@mi.cl",z$Mail),]
z10 <- z[grep("@manquehue.net",z$Mail),]
z11 <- z[grep("@ctc-mundo.net",z$Mail),]
z12 <- z[grep("@banco",z$Mail),]
z13 <- z[grep("@uc.cl",z$Mail),]
z14 <- z[grep("@terra.cl",z$Mail),]
z15 <- z[grep("@vina",z$Mail),]
z16 <- z[grep("@hacienda",z$Mail),]
z17 <- z[grep("@min",z$Mail),]
z18 <- z[grep("@usa",z$Mail),]
z19 <- z[grep("@com",z$Mail),]
z20 <- z[grep("@cor",z$Mail),]
