#Financial data of schools in WA

library("httr")
library("jsonlite")
library("dplyr")
#setwd("~/Documents/FALL17/201/test-final")
source('api_key.R')

#vt0a8p2WPxbldiZD4QipQNjFsCLAQH2ZA5USPUQd
#https://api.data.gov/ed/collegescorecard/v1/schools?api_key=vt0a8p2WPxbldiZD4QipQNjFsCLAQH2ZA5USPUQd&fields=school.name,2015.cost.tuition.in_state,2015.cost.tuition.out_of_state,2015.student.demographics.avg_family_income_log&school.state=WA


GetFinData <- function(input.year) {
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
    tuition <- paste0(input.year, ".cost.tuition.in_state,", input.year, ".cost.tuition.out_of_state")
    debt <- paste0(input.year, ".aid.median_debt.income.0_30000,", 
                   input.year, ".aid.median_debt.income.30001_75000,",
                   input.year, ".aid.median_debt.income.greater_than_75000")
    query.params$fields <- paste("school.name", tuition, debt, sep=",")
    query.params$page <- p
    response <- GET(base.uri, query = query.params)
    content <- content(response, "text")
    body.data <- fromJSON(content) #extract and parse
    page.data <- flatten(body.data$results) 
    state.data <- rbind(state.data, page.data) #merging the current state data with the current page data
  }
  state.data <- state.data[,c("school.name", 
                              paste0(input.year, ".cost.tuition.in_state"),
                              paste0(input.year, ".cost.tuition.out_of_state"),
                              paste0(input.year, ".aid.median_debt.income.0_30000"),
                              paste0(input.year, ".aid.median_debt.income.30001_75000"),
                              paste0(input.year, ".aid.median_debt.income.greater_than_75000"))]
  names(state.data) <- c("school.name",
                         "tuition.in",
                         "tuition.out",
                         "debt.low",
                         "debt.med",
                         "debt.high")
  state.data <- state.data %>% mutate(tuition.in = ifelse(is.na(tuition.in), "Not Available", tuition.in))
  state.data <- state.data %>% mutate(tuition.out = ifelse(is.na(tuition.out), "Not Available", tuition.out))
  state.data <- state.data %>% mutate(debt.low = ifelse(is.na(debt.low), "Not Available", debt.low))
  state.data <- state.data %>% mutate(debt.med = ifelse(is.na(debt.med), "Not Available", debt.med))
  state.data <- state.data %>% mutate(debt.high = ifelse(is.na(debt.high), "Not Available", debt.high))
  
  names(state.data) <- c("School Name",
                         "In-State Tuition",
                         "Out-of-State Tuition",
                         "Median Debt (Low Income Students)",
                         "Median Debt (Middle Income Students)",
                         "Median Debt (High Income Students)")
  
  return(state.data)
}




