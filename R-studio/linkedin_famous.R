Write a query to determine the popularity of a post on LinkedIn

Popularity is defined by number of actions (likes, comments, shares, etc.) divided by the number impressions the post received * 100.

If the post receives a score higher than 1 it was very popular.

Return all the post IDs and their popularity where the score is 1 or greater.

Order popularity from highest to lowest.


library(dplyr)

 answer <- linkedin_posts %>% mutate (
  popularity = (actions/impressions) * 100
) %>%
select (
  post_id, popularity 
) %>%
filter (
  popularity > 1
) %>%
arrange(
  desc(popularity)
)
