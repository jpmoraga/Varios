
Mail_Valido <- function(x)
    {
      x <- gsub("unknown","",gsub("\n","",gsub("/","",gsub(",","",gsub(";","",as.character(x))))))
      x <- sub("gmail.cl","gmail.com",as.character(x))
      x <- sub("hotmail.cl","hotmail.com",as.character(x))
      if(length(which(strsplit(as.character(x), '')[[1]]=='@')) != 1){x <- NULL}
      ##if(length(which(strsplit(as.character(x), '')[[1]]=='.')) != 0){x <- NULL}
      ##if(nchar(x) > 80){x <- NULL}
      ##if(nchar(x) < 6){x <- NULL}
      ##if(substr(as.character(x),1,1) %in% c("0","1","2","3","4","5","6","7","8","9")){x <- NULL}
      x
    }
