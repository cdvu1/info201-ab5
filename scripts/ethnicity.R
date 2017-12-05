library(jsonlite)
library(dplyr)
library(httr)
# setwd("~/INFO201/final-project")
source('api_key.R')

# Ethnicity Pie Chart for Schools in WA State
# 546-552
# Widgets: state drop-down, year slider

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
    query.params$fields <- paste("school.name", 
                                  "2015.student.demographics.race_ethnicity.white", 
                                  "2015.student.demographics.race_ethnicity.black",
                                  "2015.student.demographics.race_ethnicity.hispanic",
                                  "2015.student.demographics.race_ethnicity.asian",
                                  "2015.student.demographics.race_ethnicity.aian",
                                  "2015.student.demographics.race_ethnicity.nhpi",
                                  "2015.student.demographics.race_ethnicity.two_or_more",
                                  "2015.student.demographics.race_ethnicity.non_resident_alien",
                                  "2015.student.demographics.race_ethnicity.unknown",
                                  "2015.student.demographics.race_ethnicity.white_non_hispanic",
                                  "2015.student.demographics.race_ethnicity.black_non_hispanic",
                                  "2015.student.demographics.race_ethnicity.asian_pacific_islander", 
                                  sep=",")
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    state.data <- rbind(state.data, page.data) #merging the current state data with the current page data
  }
  return(state.data)
}



state.data <- GetData(2015)


#https://api.data.gov/ed/collegescorecard/v1/schools?api_key=vt0a8p2WPxbldiZD4QipQNjFsCLAQH2ZA5USPUQd&fields=school.name&school.state=WA




