# Install SocialMediaMineR

install.packages("SocialMediaMineR")

# Searching on Social Media

library(SocialMediaMineR)
library(XML)

# Search on facebook

fb_results <- get_facebook("http://www.bbc.com/")

# Search on Pinterest

pinterest_results <- get_pinterest("http://www.bbc.com/")

# Search on Reddit

reddit_results <- get_reddit("http://www.bbc.com/")

fb_results
pinterest_results
reddit_results

# Popularity of the URL from multiple social networking websites
news_urls<- c(
  "http://www.bbc.com/",
  "http://www.euronews.com/",
  "http://www.cnn.com/",
  "http://www.nytimes.com/",
  "http://www.guardian.co.uk/",
  "http://www.globalpost.com/",
  "http://www.france24.com/",
  "http://www.aljazeera.com/",
  "http://www.reuters.com/",
  "http://www.foxnews.com/",
  "http://www.nbcnews.com/",
  "http://www.huffingtonpost.com/",
  "http://www.wsj.com/",
  "http://www.ndtv.com/")

allresults<- get_socialmedia(news_urls, sleep.time = 0)
allresults

# Use Google Maps

install.packages("RgoogleMaps")
library(RgoogleMaps)

# Get Geo location lat/lon

getGeoCode("Big Ben")
getGeoCode("10 Downing Street")
getGeoCode("London Eye")

# Get static map 

BigBenMap<- GetMap(center="Big Ben", zoom=13)
PlotOnStaticMap(BigBenMap)

# Plot above three places on map

lat = c(51.5007292,51.5033635,51.503324);
lon = c(-0.1246254,-0.1276248,-0.119543);
center = c(mean(lat), mean(lon));
zoom<- min(MaxZoom(range(lat), range(lon)));
Map <- GetMap(center=center,zoom=zoom,markers=paste0("&markers=color:blue|label:B|","51.5007292,-0.1246254&markers=color:green|label:D|51.5033635,-0.1276248&markers=","color:red|color:red|label:L|51.503324,-0.119543"));
PlotOnStaticMap(Map)
