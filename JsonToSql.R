Facebook_Ads <- function(json_file_txt) {

    library(RJSONIO)
    library(readtext)
    library(reshape2)
    
    
    #setwd('C:/Users/juanpablo.moraga/Desktop/CCU/Datapoint')
    #json_file <- '_Test_facebook.adsinsight-2018-02-26T20-44-53.6Z-513486576d2f45359eb5f68cbb7e07d0.txt'
    
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
    
    x <- NULL
    for(i in 1:length(json)) {
    #for(i in 1:100) {
      tryCatch({
            json1 <- json[i]
            
            json1_1 <-json1[[1]][campos]
            
            json1_2 <- json1[[1]][campos1]
            
            if(!is.na(json1_2)) {json1_2 <- json1_2$actions}
            
            json1_1 <- as.data.frame(unlist(json1_1))
            
            json1_1 <- t(as.data.frame(json1_1[unlist(json1_1) != 'video_view',]))
            
            n <- max(length(json1_1),length(campos))
            
            length(json1_1) <- n
            
            length(campos) <- n
            
            if(is.vector(json1_1)) {
              json1_1 <- as.data.frame(t(json1_1))} else {
                json1_1 <- as.data.frame(json1_1)}
            
            colnames(json1_1) <- campos
            
            json1_2_df <- as.data.frame(matrix(nrow = 1,ncol = length(campos2)))
            
            colnames(json1_2_df) <- campos2
            
            json1_2[is.na(json1_2) || is.null(json1_2)] <- '0'
            
            if(!is.null(json1_2) && !is.logical(json1_2)) {
                    for(j in 1:length(json1_2)) {
                        if('like' == as.character(json1_2[[j]][1])) {
                          json1_2_df$like <- json1_2[[j]][2]
                        }
                    }
                    for(j in 1:length(json1_2)) {
                        if('link_click' == as.character(json1_2[[j]][1])) {
                          json1_2_df$link_click <- json1_2[[j]][2]
                        }
                    }
                    for(j in 1:length(json1_2)) {
                        if('post_reaction' == as.character(json1_2[[j]][1])) {
                          json1_2_df$post_reaction <- json1_2[[j]][2]
                        }
                    }
                    for(j in 1:length(json1_2)) {
                        if('video_view' == as.character(json1_2[[j]][1])) {
                          json1_2_df$video_view <- json1_2[[j]][2]
                        }
                    }
                    for(j in 1:length(json1_2)) {
                      if('page_engagement' == as.character(json1_2[[j]][1])) {
                        json1_2_df$page_engagement <- json1_2[[j]][2]
                      }
                    }
                    for(j in 1:length(json1_2)) {
                      if('post_engagement' == as.character(json1_2[[j]][1])) {
                        json1_2_df$post_engagement <- json1_2[[j]][2]
                      }
                    }
            }
            
            json_final <- cbind(json1_1,json1_2_df)
            
            rownames(json1_2_df) <- NULL
            rownames(json_final) <- NULL
            
            x <- rbind(x,json_final)
            rownames(x) <- NULL
           
            print(i)
      }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
    }
    return(x)
}
