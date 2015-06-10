#Loop through all of these accounts and get the information you need

library(RAdwords)
library(dplyr)

#Read in a list of clients. This data will need to be exported on the MCC level. 
clients <- read.csv("clients.csv", header = TRUE, sep = ",")

#Client ID's to account for looping
accounts <- clients$Customer.ID

# Authentication, once done you can access all accounts in your MCC
google_auth <- doAuth()

# Specify date range, i.e. last two weeks until yesterday
yesterday <- gsub("-","",format(Sys.Date()-1,"%Y-%m-%d"))
thirtydays <- gsub("-","",format(Sys.Date()-29,"%Y-%m-%d"))

# Create statement
body <- statement(select=c("ContentImpressionShare", "ContentRankLostImpressionShare", "ContentBudgetLostImpressionShare","Date","AverageCpc", "AverageCpm", "Impressions", "Clicks"),
                  report="CAMPAIGN_PERFORMANCE_REPORT",
                  where="AdNetworkType1 = CONTENT",
                  start=20150101,
                  end=20150506)

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

#Renaming Columns and Removing NA's
names(data)[1] <- "ImpressionShare"
names(data)[2] <- "LostISRank"
names(data)[3] <- "LostISBudget"
data <- data %>% mutate(ImpressionShare = ifelse(is.na(ImpressionShare),"0",ImpressionShare))
data <- data %>% mutate(LostISBudget = ifelse(is.na(LostISBudget),"0",LostISBudget))
data <- data %>% mutate(LostISRank = ifelse(is.na(LostISRank),"0",LostISRank))
data$ImpressionShare <- as.numeric(as.character(data$ImpressionShare))
data$LostISBudget <- as.numeric(as.character(data$LostISBudget))
data$LostISRank <- as.numeric(as.character(data$LostISRank))
data$ImpressionShare <- format(round(data$ImpressionShare, 2), nsmall =2)
data$LostISBudget <- format(round(data$LostISBudget, 2), nsmall =2)
data$LostISRank <- format(round(data$LostISRank, 2), nsmall =2)
data$ImpressionShare <- as.numeric(as.character(data$ImpressionShare))
data$LostISBudget <- as.numeric(as.character(data$LostISBudget))
data$LostISRank <- as.numeric(as.character(data$LostISRank))
View(data)

#Lets summarize some data, shall we?
data2 <- data %>% group_by(Day) %>% summarize(
    ImpressionShare=mean(ImpressionShare), CPM=mean(Avg.CPM), CPC=mean(CPC))
data2$ImpressionShare <- format(round(data2$ImpressionShare, 2), nsmall =2)
data2$CPM <- format(round(data2$CPM, 2), nsmall =2)
data2$CPC <- format(round(data2$CPC, 2), nsmall =2)
data2$ImpressionShare <- as.numeric(as.character(data2$ImpressionShare))
data2$CPM <- as.numeric(as.character(data2$CPM))
data2$CPC <- as.numeric(as.character(data2$CPC))
View(data2)

#Plot Impression Share with CPM and CPC
data3 <- melt(data2, id="Day")
ggplot(data3, aes(x=Day, y=value, color=variable)) + geom_line()
