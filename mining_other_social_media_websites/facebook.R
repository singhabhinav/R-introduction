# Create Facebook App https://developers.facebook.com/

# Generate token https://developers.facebook.com/tools/explorer


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


network<- getNetwork(token, format="adj.matrix")

require(igraph)

social_graph<- graph.adjacency(network)
layout<- layout.drl(social_graph,
                    options=list(simmer.attraction=0))

plot(social_graph, vertex.size=10, vertex.color="green",
     edge.arrow.size=0, edge.curved=TRUE,
     layout=layout.fruchterman.reingold)

degree(social_graph, v=V(social_graph), mode =
         c("all", "out", "in", "total"),loops = TRUE, normalized = FALSE)
degree.distribution(social_graph, cumulative = FALSE)

page<- getPage("TED", token, n = 50)

head(page, n=2)

page[which.max(page$likes_count), ]

page<- getPage("TED", token, n = 500)

pageRecent<- page[which(page$created_time> "2017-12-01"), ]
top<- pageRecent[order(- pageRecent$likes),]
colnames(top)

View(top)


post_id<- head(page$id, n = 1)
post<- getPost(post_id, token, n = 1000, likes = TRUE,
               comments = TRUE)

View(post$comments)
head(post$comments, n=2)

library(sqldf)
comments <- post$comments
influentialusers<- sqldf("select from_name, sum(likes_count)
                         as totlikes from comments group by from_name")
head(Infusers)
head(Infusers)
influentialusers$totlikes<- as.numeric(influentialusers$totlikes)
# Sorting the users based on the number of likes they received
top<- influentialusers[order(- influentialusers$totlikes),]
View(top)
