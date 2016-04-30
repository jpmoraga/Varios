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

z1 <- z[grep("@gmail.com",z$Mail),] ## gmail
z2 <- z[grep("@hotmail.com",z$Mail),] ## hotmail
z3 <- z[grep("@yahoo.com",z$Mail),] ## yahoo.com
z4 <- z[grep("@yahoo.es",z$Mail),] ## yahoo.es
z5 <- z[grep("@uai.cl",z$Mail),] ## uai
z6 <- z[grep("@uandes.cl",z$Mail),] ## uandes
z7 <- z[grep("@entelchile.net",z$Mail),] ## EntelChile