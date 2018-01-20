library(devtools)
install_github("pablobarbera/instaR/instaR")
library(instaR)


app_id<- ""
app_secret<- ""
token<- instaOAuth(app_id, app_secret)

token


instag <- getUserMedia("barackobama", token, n=100, folder="instagram")

usr<- getUser("barackobama", token)

Tag1<- getTagCount("photoftheday",token)
Tag1
