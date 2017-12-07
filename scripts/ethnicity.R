# Ethnicity Pie Chart for Schools in WA State
# 546-552
# Widgets: school drop-down, year slider

library(jsonlite)
library(dplyr)
library(httr)

rachel.key <- 'w18o8eFdTJoicgBpEaAIrOGYBISjuazU2OnogG4G'

GetRaceData <- function(input.year) {
  base.uri <- 'https://api.data.gov/ed/collegescorecard/v1/schools/'
  query.params <- list(api_key = rachel.key, fields = "school.name", school.state = "WA")
  response <- GET(base.uri, query = query.params)
  content <- content(response, "text")
  body.data <- fromJSON(content) #extract and parse
  state.data <- data.frame() #empty dataframe 
  
  #get total number of pages by dividing total data and num of data per page
  total.pages <- trunc(body.data$metadata$total / body.data$metadata$per_page)
  
  #for loop to each page and add that page's data into state.data
  for(p in 1:total.pages) {
    query.params$fields <- paste0("school.name,", 
                                 input.year, ".student.demographics.race_ethnicity.white,", 
                                 input.year, ".student.demographics.race_ethnicity.black,",
                                 input.year, ".student.demographics.race_ethnicity.hispanic,",
                                 input.year, ".student.demographics.race_ethnicity.asian,",
                                 input.year, ".student.demographics.race_ethnicity.aian,",
                                 input.year, ".student.demographics.race_ethnicity.nhpi,",
                                 input.year, ".student.demographics.race_ethnicity.two_or_more,",
                                 input.year, ".student.demographics.race_ethnicity.non_resident_alien,",
                                 input.year, ".student.demographics.race_ethnicity.unknown,",
                                 input.year, ".student.demographics.race_ethnicity.white_non_hispanic,",
                                 input.year, ".student.demographics.race_ethnicity.black_non_hispanic,",
                                 input.year, ".student.demographics.race_ethnicity.asian_pacific_islander" 
                                  )
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    state.data <- rbind(state.data, page.data) #merging the current state data with the current page data
  }
  return(state.data)
}

# Reference data frame for list of schools in selectInput widget on Race/Ethnicity tab
state.data <- GetRaceData(2015)
sort.state.data <- arrange(state.data, school.name)


