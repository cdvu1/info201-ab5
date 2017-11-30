#Financial data of schools in WA
#Family income: line 561ish
#Financial aid: line 777ish
#Table (avg cost of attendance, avg family income, avg financial aid received, avg loans)

library("httr")
library("jsonlite")
library("dplyr")
setwd("~/Documents/FALL17/201/info201-ab5/")
source('api_key.R')

#https://api.data.gov/ed/collegescorecard/v1/schools?api_key=<APIKEYHERE>&fields=school.name,2016.cost.tuition.in_state,2016.cost.tuition.out_of_state&school.state=WA


GetData <- function(input.year) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "school.name", school.state = "WA")
  response <- GET(base.uri, query = query.params)
  content <- content(response, "text")
  body.data <- fromJSON(content) #extract and parse
  state.data <- data.frame() #empty dataframe 
  
  #get total number of pages by dividing total data and num of data per page
  total.pages <- trunc(body.data$metadata$total / body.data$metadata$per_page)
  
  #for loop to each page and add that page's data into state.data
  for(p in 1:total.pages) {
    query.params$fields <- "school.name,2015.cost.tuition.in_state,2015.cost.tuition.out_of_state"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    state.data <- rbind(state.data, page.data) #merging the current state data with the current page data
  }
  return(state.data)
}


