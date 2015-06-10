# Analyzing-Adwords-in-R

This repo contains a set up scripts that I use in R with the <a href="https://github.com/jburkhardt/RAdwords">RAdwords</a> package by Johannes Burkhardt.

#<a href="https://github.com/chipoglesby/Analyzing-Adwords-in-R/blob/master/account_performance_report.R">Account Performance Report</a>
The account performance report script loads a list of clients, looping through each account and pulls data from the <a href="https://developers.google.com/adwords/api/docs/appendix/reports/account-performance-report">ACCOUNT_PERFORMANCE_REPORT</a> in the Google AdWords API.
<p> Use this script to see the overall performance of each account that you manage.

#<a href="https://github.com/chipoglesby/Analyzing-Adwords-in-R/blob/master/content_impression_share_by_date.R">Display Impression Share Report</a>
The Display Impression Share Report script loads a list of clients, looping through each account and pulls data from the <a href="https://developers.google.com/adwords/api/docs/appendix/reports/campaign-performance-report">CAMPAIGN_PERFORMANCE_REPORT</a> in the Google AdWords API. 
<p>If you've switched from a CPC bid to a viewable CPM bid, this script will plot the performance of your impression share overtime. Use this script to analyze the effectiveness of different types of bids.

#<a href="https://github.com/chipoglesby/Analyzing-Adwords-in-R/blob/master/display%20placement%20report.R">Display Placement Report</a>
The display placement performance report script loads a list of clients, looping through each account and pulls data from the <a href="https://developers.google.com/adwords/api/docs/appendix/reports/placement-performance-report">PLACEMENT_PERFORMANCE_REPORT</a> in the Google AdWords API.
<p>If you manage a large set of accounts in a given vertical you can use this script to analyze the performance of all placements in your accounts. You an also export those placements as a csv and bulk upload them into Adwords as negatives.

#<a href="https://github.com/chipoglesby/Analyzing-Adwords-in-R/blob/master/forecasting%20costs.R">Forecasting Account Costs</a>
This script will creates a forecast of PPC costs using historic data and the <a href="http://cran.r-project.org/web/packages/forecast/index.html">R package forecast.</a>

#<a href="https://github.com/chipoglesby/Analyzing-Adwords-in-R/blob/master/keywords_with_qs_30days.R">Keywords Performance Report</a>
The keyword performance report script loads a list of clients, looping through each account and pulls data from the <a href="https://developers.google.com/adwords/api/docs/appendix/reports/keywords-performance-report">KEYWORDS_PERFORMANCE_REPORT</a> in the Google AdWords API.
<p>This script is useful if you have accounts in a given vertical in different geographical regions and want to analyze the performance of keywords with quality scores. It also plots a histogram of quality score for keywords.

#<a href="https://github.com/chipoglesby/Analyzing-Adwords-in-R/blob/master/search_query_performance.R">Search Query Performance Report</a>
The search query performance report script loads a list of clients, looping through each account and pulls data from the <a href="https://developers.google.com/adwords/api/docs/appendix/reports/search-qery-performance-report">SEARCH_QUERY_PERFORMANCE_REPORT</a> in the Google AdWords API.
<p>This script is useful if you have accounts in a given vertical in different geographical regions and want to analyze the performance of your search queries.
