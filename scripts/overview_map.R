library(jsonlite)
library(httr)
library(dplyr)
source("api_key.R")
library(reshape)
library(reshape2)

#Jody's working directory
setwd("~/Downloads/INFO201/info201-ab5")


# get school names
GetSchoolName <- function(input.state) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "school.name")
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
    query.params$fields <- "school.name"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    state.data <- rbind(state.data, page.data) #merging the current state data with the current page data
  }
  return(state.data)
}

# get state
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

# get cities of schools
GetCity <- function(input.state) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "school.city")
  response <- GET(base.uri, query = query.params)
  content <- content(response, "text")
  body.data <- fromJSON(content) #extract and parse
  
  str(body.data)
  names(body.data)
  items <- body.data$items
  is.data.frame(items)
  
  city.data <- data.frame()
  
  #get total number of pages by dividing total data and num of data per page
  all.pages <- trunc(body.data$metadata$total / body.data$metadata$per_page)
  
  #for loop to each page and add that page's data into state.data
  for(p in 1:all.pages) {
    query.params$fields <- "school.city"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    city.data <- rbind(city.data, page.data) #merging the current state data with the current page data
  }
  return(city.data)
}

# get lats of schools
GetLat <- function(input.state) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "location.lat")
  response <- GET(base.uri, query = query.params)
  content <- content(response, "text")
  body.data <- fromJSON(content) #extract and parse
  
  str(body.data)
  names(body.data)
  items <- body.data$items
  is.data.frame(items)
  
  lat.data <- data.frame()
  
  #get total number of pages by dividing total data and num of data per page
  all.pages <- trunc(body.data$metadata$total / body.data$metadata$per_page)
  
  #for loop to each page and add that page's data into state.data
  for(p in 1:all.pages) {
    query.params$fields <- "location.lat"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    lat.data <- rbind(lat.data, page.data) #merging the current state data with the current page data
  }
  return(lat.data)
}

# get longs of schools
GetLong <- function(input.state) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "location.lon")
  response <- GET(base.uri, query = query.params)
  content <- content(response, "text")
  body.data <- fromJSON(content) #extract and parse
  
  str(body.data)
  names(body.data)
  items <- body.data$items
  is.data.frame(items)
  
  lon.data <- data.frame()
  
  #get total number of pages by dividing total data and num of data per page
  all.pages <- trunc(body.data$metadata$total / body.data$metadata$per_page)
  
  #for loop to each page and add that page's data into state.data
  for(p in 1:all.pages) {
    query.params$fields <- "location.lon"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    lon.data <- rbind(lon.data, page.data) #merging the current state data with the current page data
  }
  return(lon.data)
}

# get admission rates of schools
GetAdmissionsRate <- function(input.state) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "2015.admissions.admission_rate.overall")
  response <- GET(base.uri, query = query.params)
  content <- content(response, "text")
  body.data <- fromJSON(content) #extract and parse
  
  str(body.data)
  names(body.data)
  items <- body.data$items
  is.data.frame(items)
  
  adm.data <- data.frame()
  
  #get total number of pages by dividing total data and num of data per page
  all.pages <- trunc(body.data$metadata$total / body.data$metadata$per_page)
  
  #for loop to each page and add that page's data into state.data
  for(p in 1:all.pages) {
    query.params$fields <- "2015.admissions.admission_rate.overall"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    adm.data <- rbind(adm.data, page.data) #merging the current state data with the current page data
  }
  return(adm.data)
}

# get number of bachelors of library sciences at schools (lines 422)
GetBachLib <- function(input.state) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "2015.academics.program.bachelors.library")
  response <- GET(base.uri, query = query.params)
  content <- content(response, "text")
  body.data <- fromJSON(content) #extract and parse
  
  str(body.data)
  names(body.data)
  items <- body.data$items
  is.data.frame(items)
  
  bach.data <- data.frame()
  
  #get total number of pages by dividing total data and num of data per page
  all.pages <- trunc(body.data$metadata$total / body.data$metadata$per_page)
  
  #for loop to each page and add that page's data into state.data
  for(p in 1:all.pages) {
    query.params$fields <- "2015.academics.program.bachelors.library"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    bach.data <- rbind(bach.data, page.data) #merging the current state data with the current page data
  }
  return(bach.data)
}

# get percent of first generation students (line 1643)
GetFirstGen <- function(input.state) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "2015.student.share_firstgeneration")
  response <- GET(base.uri, query = query.params)
  content <- content(response, "text")
  body.data <- fromJSON(content) #extract and parse
  
  str(body.data)
  names(body.data)
  items <- body.data$items
  is.data.frame(items)
  
  gen.data <- data.frame()
  
  #get total number of pages by dividing total data and num of data per page
  all.pages <- trunc(body.data$metadata$total / body.data$metadata$per_page)
  
  #for loop to each page and add that page's data into state.data
  for(p in 1:all.pages) {
    query.params$fields <- "2015.student.share_firstgeneration"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    gen.data <- rbind(gen.data, page.data) #merging the current state data with the current page data
  }
  return(gen.data)
}

# getting all of the data
school.names <- GetSchoolName("OR")
school.state <- GetState("OR")
school.city <- GetCity("WA")
school.lat <- GetLat("WA")
school.long <- GetLong("WA")
school.admissions <- GetAdmissionsRate("WA")
school.bachelors <- GetBachLib("WA")
school.firstgen <- GetFirstGen("WA")

# by=c("School", "State", "City", "Latitiude", "Longitude", "Admissions Rate",
# "Bachelors in Library Sciences", "Percentage of First-Gens")
# merging the datas into one
all.df <- list(school.names, school.state, school.city, school.lat, school.long,
                           school.admissions, school.bachelors, school.firstgen)
merged.df <- merge_all(all.df)





