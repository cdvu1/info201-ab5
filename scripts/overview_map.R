library(jsonlite)
library(httr)
library(dplyr)

# https://api.data.gov/ed/collegescorecard/v1/schools?api_key=fDjxnzknPKeKvMcOlzCAb6aK3IhayEClNrqG4zxF&fields=school.name,school.state,school.city,location.lat,location.lon,2015.admissions.admission_rate.overall,2015.academics.program.bachelors.library,2015.student.share_firstgeneration&sort=school.name
jody.key <- "uouIjx1yZKGc8rnMS55fVmL1qD11jeydjNz5QHKi"

GetData <- function(input.year) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = jody.key, fields = "school.name,school.state,school.city,location.lat,location.lon")
  response <- GET(base.uri, query = query.params)
  content <- content(response, "text")
  body.data <- fromJSON(content) #extract and parse
  school.data <- data.frame()
  
  #get total number of pages by dividing total data and num of data per page
  all.pages <- trunc(body.data$metadata$total / body.data$metadata$per_page)
  
  #for loop to each page and add that page's data into state.data
  for(p in 1:all.pages) {
    all.data <- paste0("school.name,school.state,school.city,location.lat,location.lon,", 
                       input.year, ".admissions.admission_rate.overall,",
                       input.year, ".academics.program.bachelors.library,",
                       input.year, ".student.share_firstgeneration")
    query.params$fields <- paste(all.data)
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    school.data <- rbind(school.data, page.data) #merging the current state data with the current page data
  }
  return(school.data)
}

school.info <- GetData("2015")

school.info <- school.info %>% 
                mutate(`2015.student.share_firstgeneration` = `2015.student.share_firstgeneration` * 100,
                       `2015.admissions.admission_rate.overall` = `2015.admissions.admission_rate.overall` * 100)
colnames(school.info) <- c("lat", "long", "name", "library", "state", "city", "firstgen", "admissions") 

write.csv(school.info, file = 'map.data.csv')
map.data <- read.csv('map.data.csv')
