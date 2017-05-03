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
                           "DisplayName",
                           "PlacementUrl",
                           "Impressions",
                           "Clicks",
                           "Ctr",
                           "AverageCpm",
                           "AverageCpc",
                           "Cost",
                           "Conversions",
                           "ViewThroughConversions"),
                  report = "PLACEMENT_PERFORMANCE_REPORT",
                  where = "AdNetworkType1 = CONTENT",
                  start = thirtydays,
                  end = yesterday)

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

placements <- 
data %>% 
  group_by(CriteriaDisplayName) %>% 
  summarize(
    averageCpc = round(sum(Cost) / sum(Clicks),2), 
    clicks = sum(Clicks), 
    impressions = sum(Impressions), 
    ctr = round(sum(Clicks) / sum(Impressions),2), 
    cost = round(sum(Cost),2), 
    conversions = sum(Conversions), 
    cpa = round(sum(Cost) / sum(Conversions),2)) %>%
    arrange(desc(conversions))

placements[placements==Inf] <- 0

View(placements)
#write.csv(placements, "display_placements.csv")

under_performing_placements <- subset(placements, Conversions < 1)
under_performing_placements <- under_performing_placements[order(-under_performing_placements$Cost),]
View(under_performing_placements)
