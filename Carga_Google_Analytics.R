#graphene.performancehub.cl@gmail.com
#Enero.2016

#library(RGoogleAnalytics)

#client.id  <- "client.id"
#client.secret <- "client.secret"

#token <- Auth(client.id,client.secret)

library(googlesheets)
library(RODBC) 

conn <- odbcDriverConnect('driver={SQL Server};server=stgadb07;database=Analytics;trusted_connection=true')

GA <- gs_title("Google Analytics")

GA <- gs_read(ss = GA, ws = "Google Analytics")
GA <- as.data.frame(GA)

colnames(GA) <- c("Date","Ad_content","View","Campaign","Source_Medium","Sessions","New_Users","Pageviews","Avg_Time","Time_Site","Time_Page","Trans_Rev","Trans","Item_Quant")

GA[is.na(GA)] <- 0

sqlSave(conn, GA, tablename = "Google_Analytics",rownames=FALSE, append = TRUE)