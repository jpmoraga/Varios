library(RJSONIO)
library(readtext)

setwd('C:/Users/juanpablo.moraga/Desktop/CCU/Datapoint')
json_file <- '_Test_facebook.adsinsight-2018-02-26T20-44-53.6Z-513486576d2f45359eb5f68cbb7e07d0.txt'

json <- readtext(json_file)

json <- fromJSON(json[,2])

json <- json$insights$insights_data$data

campos <- c('account_id','account_name','account_currency','ad_id',
            'ad_name','adset_id','adset_name','campaign_id','campaign_name','canvas_avg_view_percent','canvas_avg_view_time','clicks','cpc','cpm',
            'cpp','ctr','date_start','date_stop','estimated_ad_recall_rate','estimated_ad_recallers','frequency','impressions','reach','social_clicks',
            'social_impressions','social_reach','spend','total_action_value','total_actions','total_unique_actions','age','gender',
            'video_10_sec_watched_actions','video_30_sec_watched_actions','video_p100_watched_actions','video_p25_watched_actions',
            'video_p50_watched_actions','video_p75_watched_actions','video_p95_watched_actions')

campos1 <- c('actions')

campos2 <- c('like','link_click','post_reaction','video_view','page_engagement','post_engagement')


#for(i in 1:length(json)) {
#for(i in 1:2) {
  
  json1 <- json[1]
  
  json1_1 <-json1[[1]][campos]
  
  json1_2 <- json1[[1]][campos1]
  
  json1_2 <- json1_2$actions
  
  json1_1 <- as.data.frame(json1_1)
  
  colnames(json1_1) <- campos
  
  json1_1 <- json1_1[2,]
  
  json1_2_df <- as.data.frame(matrix(nrow = 1,ncol = length(json1_2)))
  
  x <- NULL
  x1 <- NULL
  for(j in 1:length(json1_2)) {
    c <- json1_2[[j]][1]
    x <- cbind(x,c)
    
    c1 <- json1_2[[j]][2]
    x1 <- cbind(x1,c1)
  }
  
  colnames(json1_2_df) <- x
  colnames(x1) <- x
  json1_2_df <- rbind(x,x1)
  
  json1_2_df <- as.data.frame(json1_2_df)
  
  colnames(json1_2_df) <- x
  
  json1_2_df <- json1_2_df[2,]
  
  json_final <- cbind(json1_1,json1_2)
  
  x <- rbind(x,json_final)
#}

