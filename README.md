# Twitter-Follower-Overlap

Ever wondered how many followers you share with your favourite celeb? No? Oh.. me neither. But, if you did want to know, here’s an easy R script using rtweet and VennDiagram to find out.

This is a great little script for those ‘nice to have’ pieces of analysis for example; analyzing follower overlap for your brand and competitors or for answering questions like Do EastEnders fans like Hollyoaks? 

## Step by step


**Step 1 — Run required packages**


This script uses 3 packages:
rtweet — to collect the required data from the Twitter API.
Tidyverse — to manipulate the data.
VennDiagram — to visualize the data.


```
library(rtweet)
library(tidyverse)
library(VennDiagram)
```

When you first run the rtweet package R will attempt to open up your web browser for you to log in and allow access to Twitter.

**Step 2 — Set the accounts**


Set the accounts you’d like to analyze, for this example we’ll be looking at British Soap Twitter accounts. In the snippet below we are stating the username exactly as it is shown on Twitter. We will be storing this to be used in functions when collecting the data and later on when naming the areas of the Venn diagram to make the script reusable.

```
a_name <- “itvcorrie”
b_name <- “bbceastenders”
c_name <- “emmerdale”
d_name <- “Hollyoaks”
```

**Step 3 — Collect the data**

Next we’ll be using the get_followers function from the rtweet package to collect the user IDs of the followers of the British Soap 📺 Twitter accounts.
The following snippet will collect a table data frame of all of the user IDs stored as a,b,c and d for later use in the Venn diagram.
This step can take some time if you are analyzing accounts with a large following. First, we collect high level data about the account using the lookup_users function and store this as X_lookup. The data pull contains a column with with the total number of followers for the account.

```
a_lookup <- lookup_users(a_name)
```

Next, we take the number of followers and store as n, this will tell the next function when to stop collecting to ensure we have a full data set. If you’d like to take a sample of the data set you can apply a sampling function to this section. Without declaring n, the get_followers function will automatically take a sample of the data if it is very large.

```
n = a_lookup$followers_count
```

Now to collect the user IDs. Using the get_followers function we can state the username of interest (we stored these as a value in step 2), the number of followers we’d like to collect (n, set above) and the retryonratelimit clause set to TRUE. This will ensure that the get_followers function carries on where it left off if the rate limit is hit. Beware, the rate limit is set for your entire session and is not for each username. It can often take between 10–15 mins between hitting the rate limit and retrying so bare this in mind if you want to work with large data sets.

```
a <- get_followers(a_name, n = n, retryonratelimit = TRUE)
```

We repeat this process to pull all the data needed for the usernames stored under a,b,c,d _ name to create 4 tidy data sets.
Best put the kettle on while you wait for this section to run. ☕


```
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
```


**Step 4 — Visualize the data**


It’s 4 days later and we’ve finally collected the data we need 😄, now the moment we’ve all been waiting for, visualization!
We will be using the VennDiagram package to analyze the results.

The venn.diagram function used below focuses on the following:

- x = The data you’d like to visualize. An extra step is taken here to extract the user ID data from each of the table data frames and transform into character values, you can reduce or extend the list to match the number of users you’d like to analyze.


- category.names = the values created in step 2, you can reduce or extend the list to match the number of users you’d like to analyze.


- filename = The name of the png file containing the vector output, rename this to whatever you’d like.


- col = The border around each area, this is grey, feel free to change.


- fill = The colors you’d like each area to be, this will follow the same order as seen in x and category.names, again you can reduce or extend to match the number of users you’d like to analyze. Alpha and 0.3 in this section, indicates that the colour will be transparent and to what level.

There are many other customizations available, I recommended taking a look through the documentation for additional styling.

```
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
 filename = ‘output.png’,
 output=TRUE,
 col = alpha(“#D3D3D3”,0.3),
 fill = c(alpha(“#581845”,0.3), 
          alpha(‘#FFC300’,0.3), 
          alpha(‘#C70039’,0.3),
          alpha(‘#FF5733’,0.3))
 )
 ```
 
 When complete you will see the output in the Files pane of R Studio. Click on the file and you should have something that looks like this:
 
 
 <img width="605" alt="" src="https://miro.medium.com/max/1400/1*QOWbtGzaGxLyHCzX1yXFIA.jpeg">
 
 
So, Do EastEnders fans like Hollyoaks?
EastEnders has 2,491,993 Twitter followers, of these followers:

- 51.64% also follow Coronation Street,

- 35.62% also follow Emmerdale,

- 7.76% also follow Hollyoaks,

- 4.21% follow Coronation Street, Emmerdale and Hollyoaks,

- 2.05% follow just EastEnders and Hollyoaks.

The analysis suggests that Hollyoaks isn’t high on EastEnders fans top soap list… or perhaps they just don’t think their Tweets are interesting.
What will you discover?


Happy analyzing!
