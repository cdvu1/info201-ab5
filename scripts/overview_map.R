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
# get school names
GetSchoolName <- function(input.school) {
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

school.states <- GetState("OR")
school.names <- GetSchoolName("OR")

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
    page.data <- f(body.data$results) 
    state.data <- rbind(state.data, page.data) #merging the current state data with the current page data
  }
  return(state.data)
}

school.state <- GetState("OR")

# get cities of schools
GetCity <- function(input.city) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "school.city")
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
    query.params$fields <- "school.city"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- f(body.data$results) 
    state.data <- rbind(state.data, page.data) #merging the current state data with the current page data
  }
  return(state.data)
}

school.city <- GetCity("WA")

# get lats of schools
GetLat <- function(input.lat) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "float.lat")
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
    query.params$fields <- "float.lat"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- f(body.data$results) 
    state.data <- rbind(state.data, page.data) #merging the current state data with the current page data
  }
  return(state.data)
}

school.lat <- GetLat("WA")

# get longs of schools
GetLong <- function(input.city) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "float.long")
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
    query.params$fields <- "float.long"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- f(body.data$results) 
    state.data <- rbind(state.data, page.data) #merging the current state data with the current page data
  }
  return(state.data)
}

school.long <- GetLong("WA")

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
  
  state.data <- data.frame()
  
  #get total number of pages by dividing total data and num of data per page
  all.pages <- trunc(body.data$metadata$total / body.data$metadata$per_page)
  
  #for loop to each page and add that page's data into state.data
  for(p in 1:all.pages) {
    query.params$fields <- "2015.admissions.admission_rate.overall"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- f(body.data$results) 
    state.data <- rbind(state.data, page.data) #merging the current state data with the current page data
  }
  return(state.data)
}

school.admissions <- GetAdmissionsRate("WA")

# get number of bachelors of library sciences at schools
GetBachLib <- function(input.state) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "academics.program.bachelors.library")
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
    query.params$fields <- "academics.program.bachelors.library"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- f(body.data$results) 
    state.data <- rbind(state.data, page.data) #merging the current state data with the current page data
  }
  return(state.data)
}

school.bachelors <- GetBachLib("WA")

# get percent of first generation students
GetFirstGen <- function(input.state) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = api.key, fields = "student.share_firstgeneration")
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
    query.params$fields <- "student.share_firstgeneration"
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- f(body.data$results) 
    state.data <- rbind(state.data, page.data) #merging the current state data with the current page data
  }
  return(state.data)
}

school.firstgen <- GetFirstGen("WA")
