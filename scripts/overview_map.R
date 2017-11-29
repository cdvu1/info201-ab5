library(jsonlite)
library(httr)
library(dplyr)
source("api_key.R")

base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
query.params <- list(api_key = api.key, fields = "2015.student.share_firstgeneration")
response <- GET(base.uri, query = query.params)
content <- content(response, "text")
body.data <- fromJSON(content) #extract and parse
firstgen.data <- body.data$results
