# Create Facebook App https://developers.facebook.com/

# Generate token https://developers.facebook.com/tools/explorer

# Install packages

install.packages("devtools")
library(devtools)
install_github("Rfacebook", "pablobarbera", subdir="Rfacebook")
library(Rfacebook)

token <- ""

me<- getUsers("", token, private_info = TRUE)

me$name

me$hometown

friends<- getFriends(token, simplify = FALSE)

head(friends) # To see few of your friends

friends_data<- getUsers(friends$id, token, private_info = TRUE)

table(friends_data$gender)

table(substr(friends_data$locale, 1, 2))

table(substr(friends_data$locale, 4, 5))

table(friends_data$relationship_status)

likes<- getLikes(user="me", token=token)

head(likes)

# Trend analysis

## Get page data

page<- getPage("TED", token, n = 50)

head(page, n=2)

## Get the detail about the post which had the maximum number of likes

max_liked_post = page[which.max(page$likes_count), ]

## Most trending topics

page<- getPage("TED", token, n = 500)

## Filter the most recent posts

pageRecent<- page[which(page$created_time> "2017-12-01"), ]

## Order by likes

top<- pageRecent[order(- pageRecent$likes),]

View(top)

# Find Influencers based on single post

## find the top post 
post_id<- head(page$id, n = 1)

## Get comment and likes in the top post
post<- getPost(post_id, token, n = 1000, likes = TRUE,
               comments = TRUE)

View(post$comments)
head(post$comments, n=2)


library(sqldf)
comments <- post$comments

## Find users and number of likes they received
influentialusers<- sqldf("select from_name, sum(likes_count)
                         as totlikes from comments group by from_name")
influentialusers

## Convert likes to numeric
influentialusers$totlikes<- as.numeric(influentialusers$totlikes)

## Sorting the users based on the number of likes they received
top<- influentialusers[order(- influentialusers$totlikes),]
View(top)

# Find Influencers based on multiple post

## Get top 100 posts

post_id<- head(page$id, n = 100)
head(post_id, n=10)
post_id<- as.matrix(post_id)

## Collecting 1000 the commments from all the 100 posts
allcomments<- ""
for (i in 1:nrow(post_id))
{
  # Get upto 1000 comments for each post
  post<- getPost(post_id[i,], token, n = 1000,
                 likes = TRUE, comments = TRUE)
  comments<- post$comments
  ## Append the comments to a single data frame
  allcomments<- rbind(allcomments, comments)
}

## Consolidating the like for each user.
influentialusers<- sqldf("select from_name, sum(likes_count) as
                         totlikes from allcomments group by from_name")
influentialusers$totlikes<- as.numeric(influentialusers$totlikes)
top<- influentialusers[order(- influentialusers$totlikes),]
head(top, n=20)

# Measuring CTR performance for a page

## Convert Facebook date format to R-supported date format
format.facebook.date<- function(datestring) {
  date<- as.POSIXct(datestring,
  format = "%Y-%m-%dT%H:%M:%S+0000", tz = "GMT")
}

## Function to aggregate data(likes, comments and shares) on monthly basis
aggregate.metric<- function(metric) {
  m<- aggregate(page[[paste0(metric, "_count")]],
                list(month = page$month),
                mean)
  m$month<- as.Date(paste0(m$month, "-15"))
  m$metric<- metric
  return(m)
}

## Extract posts from Facebook
page<- getPage("TED", token, n = 500)

## Change the dates to R supported format
page$datetime<- format.facebook.date(page$created_time)
page$month<- format(page$datetime, "%Y-%m")

## Use the aggregate function
df.list<- lapply(c("likes", "comments", "shares"),
                 aggregate.metric)
df<- do.call(rbind, df.list)

View(df)

# Spam detection

page<- getPage("TED", token, n = 500)
post_id<- head(page$id, n = 100)
head(post_id, n=10)
post_id<- as.matrix(post_id)

allcomments <- ""
for (i in 1:nrow(post_id))
{
  post<- getPost(post_id[i,], token, n = 1000, likes = FALSE, comments = TRUE)
  comments<- post$comments
  allcomments<- rbind(allcomments, comments)
}

View(allcomments)


allcomments<- as.data.frame(allcomments)

allcomments$chars<- ""
allcomments$chars<- nchar(allcomments$message)

allcomments$url<- ""
allcomments$url<- grepl(".com", allcomments$message)
allcomments$spam<- ""
train<- allcomments[1:100,]
test<- allcomments[101:nrow(allcomments),]

write.csv(train,"comment-train.csv" )
write.csv(test,"comment-test.csv")

train<- read.csv("comment-train.csv" )
test<- read.csv("comment-test.csv" )

newTrain<- train[,c("likes_count", "chars", "url", "spam")]
newTest<- test[,c("likes_count", "chars", "url", "spam")]

glm.out = glm(spam ~ url, family=binomial, data=newTrain)


prediction<- predict(glm.out, newTest, type = "response")
newTest$spam<- prediction
View(newTest)