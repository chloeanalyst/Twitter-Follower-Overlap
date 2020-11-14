# Run required packages

library(tidyverse)
library(rtweet)
library(VennDiagram)

# Set the accounts you'd like to analyse

a_name <- "TWITTER USER HANDLE GOES HERE"
b_name <- "TWITTER USER HANDLE GOES HERE"
c_name <- "TWITTER USER HANDLE GOES HERE"
d_name <- "TWITTER USER HANDLE GOES HERE"

# Connect to the Twitter API using the rtweet package to collect user IDs

a <- get_followers(a_name, retryonratelimit = TRUE)
b <- get_followers(b_name, retryonratelimit = TRUE)
c <- get_followers(c_name, retryonratelimit = TRUE)
d <- get_followers(d_name, retryonratelimit = TRUE)

# Create a venn diagram to showcase the results
# x = Pulls in the user IDs collected from twitter for each user, extend/reduce as needed
# catgory.names = Pulls from the usernames assigned above, extend/reduce as needed
# filename = Change this to whatever you'd like to call the output file
# col = border colour
# fill = colour of areas in order stated in 'x', extend/reduce as needed


venn.diagram(
  x = list(
    a %>% select(user_id) %>% unlist(),
    b %>% select(user_id) %>% unlist(),
    c %>% select(user_id) %>% unlist(),
    d %>% select(user_id) %>% unlist()
  ),
  category.names = c(a_name,
                     b_name,
                     c_name,
                     d_name),
  filename = 'output.png',
  output=TRUE,
  col = alpha("#D3D3D3",0.3),
  fill = c(alpha("#581845",0.3), 
           alpha('#FFC300',0.3), 
           alpha('#C70039',0.3),
           alpha('#FF5733',0.3))
  )
