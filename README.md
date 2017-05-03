# Analyzing Adwords With `R`

This repo contains a set up scripts that I use in R with the [RAdwords](https://github.com/jburkhardt/RAdwords) package by Johannes Burkhardt.
<p>Note: Your needs and analysis will always be different. These scripts are designed to help you get AdWords data into R quickly and efficently. You will need an AdWords API token, which you can [apply for here.](https://developers.google.com/adwords/api/docs/signingup)

#[Account Performance Report](https://github.com/chipoglesby/analyzingAdwordsInR/blob/master/accountPerformanceReport.R)
The account performance report script loads a list of clients, looping through each account and pulls data from the [ACCOUNT_PERFORMANCE_REPORT](https://developers.google.com/adwords/api/docs/appendix/reports/account-performance-report) in the Google AdWords API.
<p> Use this script to see the overall performance of each account that you manage.

#[Display Impression Share Report](https://github.com/chipoglesby/analyzingAdwordsInR/blob/master/contentImpressionShareByDate.R)
The Display Impression Share Report script loads a list of clients, looping through each account and pulls data from the [CAMPAIGN_PERFORMANCE_REPORT](https://developers.google.com/adwords/api/docs/appendix/reports/campaign-performance-report) in the Google AdWords API. 
<p>If you've switched from a CPC bid to a viewable CPM bid, this script will plot the performance of your impression share overtime. Use this script to analyze the effectiveness of different types of bids.

#[Display Placement Report](https://github.com/chipoglesby/analyzingAdwordsInR/blob/master/displayPlacementReport.R)
The display placement performance report script loads a list of clients, looping through each account and pulls data from the [PLACEMENT_PERFORMANCE_REPORT](https://developers.google.com/adwords/api/docs/appendix/reports/placement-performance-report) in the Google AdWords API.
<p>If you manage a large set of accounts in a given vertical you can use this script to analyze the performance of all placements in your accounts. You an also export those placements as a csv and bulk upload them into Adwords as negatives.

#[Forecasting Account Costs](https://github.com/chipoglesby/analyzingAdwordsInR/blob/master/forecastingCosts.R)
This script will creates a forecast of PPC costs using historic data and the [R package `forecast`.](http://cran.r-project.org/web/packages/forecast/index.html)

#[Keywords Performance Report](https://github.com/chipoglesby/analyzingAdwordsInR/blob/master/keywordsWithQs30days.R)
The keyword performance report script loads a list of clients, looping through each account and pulls data from the [KEYWORDS_PERFORMANCE_REPORT](https://developers.google.com/adwords/api/docs/appendix/reports/keywords-performance-report) in the Google AdWords API.
<p>This script is useful if you have accounts in a given vertical in different geographical regions and want to analyze the performance of keywords with quality scores. It also plots a histogram of quality score for keywords.

#[https://github.com/chipoglesby/analyzingAdwordsInR/blob/master/searchQueryPerformance.R](Search Query Performance Report)
The search query performance report script loads a list of clients, looping through each account and pulls data from the [SEARCH_QUERY_PERFORMANCE_REPORT](https://developers.google.com/adwords/api/docs/appendix/reports/search-qery-performance-report) in the Google AdWords API.
<p>This script is useful if you have accounts in a given vertical in different geographical regions and want to analyze the performance of your search queries.
