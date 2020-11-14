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
# If you would like a sample of the followers replace X_lookup$followers_count with a number of your choice or a sampling function

a_lookup <- lookup_users(a_name)
n = a_lookup$followers_count
a <- get_followers(a_name, n = n, retryonratelimit = TRUE)


b_lookup <- lookup_users(b_name)
n = b_lookup$followers_count
b <- get_followers(b_name, n = n, retryonratelimit = TRUE)


c_lookup <- lookup_users(c_name)
n = c_lookup$followers_count
c <- get_followers(c_name, n = n, retryonratelimit = TRUE)


d_lookup <- lookup_users(d_name)
n = d_lookup$followers_count
d <- get_followers(d_name, n = n, retryonratelimit = TRUE)



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
