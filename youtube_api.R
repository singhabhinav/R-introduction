devtools::install_github("soodoku/tuber")

library('tuber')

yt_oauth(app_id="xxxxx", app_secret="xxxx", token = '')

get_stats(video_id = "N708P-A45D0")

d = get_video_details(video_id = "N708P-A45D0")
View(d)

c = get_captions(video_id="N708P-A45D0")


search = yt_search("Barack Obama")
View(search)

all_comments = get_all_comments(video_id = "N708P-A45D0")
View(all_comments)


a <- list_channel_resources(filter = c(channel_id = "UCT5Cx1l4IS3wHkJXNyuj4TA"), part="contentDetails")
View(a)

playlist_id <- a$items[[1]]$contentDetails$relatedPlaylists$uploads

channel_status = get_channel_stats("UCT5Cx1l4IS3wHkJXNyuj4TA")
