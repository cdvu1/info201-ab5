library(jsonlite)
library(httr)
library(dplyr)
source("api_key.R")

#Jody's working directory
setwd("~/Downloads/INFO201/info201-ab5")


# the error that i get "No encoding supplied: defaulting to UTF-8."
GetState <- function(input.state) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "school.state")
  response <- GET(base.uri, query = query.params)
  content <- content(response, "text")
  body.data <- fromJSON(content) #extract and parse
  
  str(body.data)
  names(body.data)
  items <- body.data$items
  is.data.frame(items)
  
  state.data <- data.frame()
  
  #get total number of pages by dividing total data and num of data per page
  all.pages <- trunc(body.data$metadata$total / body.data$metadata$per_page)
  
  #for loop to each page and add that page's data into state.data
  for(p in 1:all.pages) {
    query.params$fields <- "school.state"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    state.data <- rbind(state.data, page.data) #merging the current state data with the current page data
  }
  return(state.data)
}

school.states <- GetState("OR")

