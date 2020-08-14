#Scrape World Rugby player Profiles for DOB, height and weight
library(rvest)
library(stringr)
library(tidyverse)
#set session, link not used
s <- html_session("https://www.world.rugby/sevens-series/calendar")

playerdeets <- data.frame(matrix(nrow = 30000, ncol = 4))
for(i in 51512:70000){
  playerpage <- s %>% jump_to(paste0("https://www.world.rugby/sevens-series/player/mens/",i)) %>% read_html()
  k <- playerpage %>%
    html_nodes(".playerSummary__name") %>% html_text()
  if (identical(k, character(0))) next
  playerdeets[i,1] <- k
   meta<-playerpage %>%
    html_nodes(".meta") %>% html_text()
  info_details <- playerpage %>%
    html_nodes(".info") %>% html_text()
  playerdeets[i,2] <- ifelse(identical(meta, character(0)),  info_details[2], meta)
  playerdeets[i,3] <-ifelse(identical(meta, character(0)),  info_details[3], info_details[2])  
  playerdeets[i,4] <-ifelse(identical(meta, character(0)),  info_details[4], info_details[3])    
        
}

fulldeets<-playerdeets[complete.cases(playerdeets), ]
