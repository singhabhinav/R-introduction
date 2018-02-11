# Installation

devtools::install_github("soodoku/tuber")

library('tuber')

# Authenticate

app_id <- "xxxxxxx"
app_secret <- "xxxxxx"

yt_oauth(app_id=app_id, app_secret=app_secret, token = '')

# Get Statistics of a Video

get_stats(video_id = "N708P-A45D0")

# Get Information About a Video

video_info = get_video_details(video_id = "N708P-A45D0")
View(video_info)

# Search Videos

search = yt_search("Barack Obama")
View(search)

# Get All the Comments Including Replies

all_comments = get_all_comments(video_id = "N708P-A45D0")
View(all_comments)

#Get only comments

res <- get_comment_threads(c(video_id="N708P-A45D0"))
View(res)