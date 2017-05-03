#Loop through all of these accounts and get the information you need

library(RAdwords)
library(dplyr)

#Read in a list of clients. This data will need to be exported on the MCC level. 
clients <- read.csv("clients.csv", header = TRUE, sep = ",")

#Client ID's to account for looping
accounts = as.vector(clients$Customer.ID)
# Authentication, once done you can access all accounts in your MCC
google_auth <- doAuth()

# Specify date range, i.e. last two weeks until yesterday
yesterday <- gsub("-", "", format(Sys.Date()-1,"%Y-%m-%d"))
thirtydays<- gsub("-", "", format(Sys.Date()-29,"%Y-%m-%d"))

# Create statement
body <- statement(select = c("AccountDescriptiveName",
                             "CampaignName",
                             "AdGroupName",
                             "KeywordText",
                             "KeywordMatchType",
                             "QualityScore",
                             "Impressions",
                             "Clicks",
                             "Ctr", 
                             "ConvertedClicks",
                             "AverageCpc"),
                  report = "KEYWORDS_PERFORMANCE_REPORT",
                  where = "Impressions >1 AND AdNetworkType1 = SEARCH",
                  start = thirtydays,
                  end = yesterday)

#   data <- getData(clientCustomerId='xxx-xxx-xxxx', google_auth=google_auth ,statement=body)


#Loop over accounts and rbind data to dataframe
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

#Change Quality Score to numeric
data$Qualityscore = as.numeric(as.character(data$Qualityscore))

#Histogram of Quality Score
hist(data$Qualityscore)

#To remove data:
#remove(data)

data2.copy <- data %>% 
  group_by(Matchtype) %>% 
  summarize(averageQS = mean(Qualityscore),
            clicks=sum(Clicks))
