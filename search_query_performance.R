#Loop through all of these accounts and get the information you need

library(RAdwords)

clients <- read.csv("clients.csv", header = TRUE, sep = ",")

accounts <- clients$Customer.ID
google_auth <- doAuth()

yesterday <- gsub("-","",format(Sys.Date()-1,"%Y-%m-%d"))
thirtydays <- gsub("-","",format(Sys.Date()-29,"%Y-%m-%d"))

body <- statement(select=c("AccountDescriptiveName","CampaignName","AdGroupName","KeywordTextMatchingQuery","Query","MatchTypeWithVariant","Impressions","Clicks","Ctr", "ConvertedClicks","AverageCpc","Cost","AveragePosition","Date"),
                  report="SEARCH_QUERY_PERFORMANCE_REPORT",
                  start=thirtydays,
                  where="CampaignName DOES_NOT_CONTAIN_IGNORE_CASE RLSA",
                  end=yesterday)

loopData <- function(){
  for(i in 1:length(accounts)){
    if (i == 1){
      xy <- getData(clientCustomerId=accounts[i],statement=body,google_auth = google_auth,transformation=TRUE,changeNames=TRUE)
    }
    else {
      xz <- getData(clientCustomerId=accounts[i],statement=body,google_auth = google_auth,transformation=TRUE,changeNames=TRUE)
      xy <- rbind(xy,xz)
    }
  }
  return(xy)
}
data <- loopData()

#Summarizing data in Accounts by Search Term
library(dplyr)
data2 <- data %>% group_by(Account,Searchterm) %>% 
  summarize(Impressions=sum(Impressions), Clicks=sum(Clicks), Conversion=sum(Conversions), CPC=mean(CPC), AvgPosition=mean(Position))
