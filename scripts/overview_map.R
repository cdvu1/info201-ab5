library(jsonlite)
library(httr)
library(dplyr)
source("api_key.R")

# https://api.data.gov/ed/collegescorecard/v1/schools?api_key=fDjxnzknPKeKvMcOlzCAb6aK3IhayEClNrqG4zxF&fields=school.name,school.state,school.city,location.lat,location.lon,2015.admissions.admission_rate.overall,2015.academics.program.bachelors.library,2015.student.share_firstgeneration&sort=school.name

GetData <- function(input.year) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "school.name,school.state,school.city,location.lat,location.lon")
  response <- GET(base.uri, query = query.params)
  content <- content(response, "text")
  body.data <- fromJSON(content) #extract and parse
  
  str(body.data)
  names(body.data)
  items <- body.data$items
  is.data.frame(items)
  
  school.data <- data.frame()
  
  #get total number of pages by dividing total data and num of data per page
  all.pages <- trunc(body.data$metadata$total / body.data$metadata$per_page)
  
  #for loop to each page and add that page's data into state.data
  for(p in 1:all.pages) {
    school.data <- paste0(input.year, ".admissions.admission_rate.overall",
                          input.year, ".academics.program.bachelors.library",
                          input.year, ".student.share_firstgeneration")
    query.params$fields <- paste("school.name,school.state,school.city,location.lat,location.lon", school.data, seq=",")
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    school.data <- rbind(school.data, page.data) #merging the current state data with the current page data
  }
  return(school.data)
}

GetData("WA")


