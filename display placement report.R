#Loop through all of these accounts and get the information you need

library(RAdwords)

#Read in a list of clients that you've exported from your MCC
clients <- read.csv("clients.csv", header = TRUE, sep = ",")

#Client ID's to account for looping
accounts <- clients$Customer.ID

# Authentication, once done you can access all accounts in your MCC
google_auth <- doAuth()

# Specify date range, i.e. last two weeks until yesterday
yesterday <- gsub("-","",format(Sys.Date()-1,"%Y-%m-%d"))
thirtydays<- gsub("-","",format(Sys.Date()-29,"%Y-%m-%d"))

# Create statement
body <- statement(select=c("AccountDescriptiveName", "CampaignName", "AdGroupName", "PlacementUrl","Impressions","Clicks","Ctr","AverageCpm","Cost"),
                  report="PLACEMENT_PERFORMANCE_REPORT",
                  where="AdNetworkType1 = CONTENT",
                  start=thirtydays,
                  end=yesterday)

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
