library(shiny)
library(plotly)

source("./scripts/ethnicity.R")
source("./scripts/financial.R")

my.ui <- navbarPage(
  
  # Application Title
  "College Data", 
  tabPanel("Map",
           sidebarLayout(
             "#Overview
             Applying for colleges for the very first time can be hard and sometimes you don't know what are the best options out there.
             Especially if you are a first-generation student. There are many choices of universities all over the U.S so choosing the 
             one that that best fits you can be difficult with so many options.
             
             This application was written for college applicants to use. Researching college information and statistics is a lengthy and 
             stressful process. In order to help these students who are going through this process, we have selected data such as demographic 
             information, financial/tution rates, etc in the Washington state. We represent these visually in this interactive web application. 
             
             #Data Source
             The dataset our group decided to work with was the College Scorecard’s data. This dataset was created by the United States department 
             of education where their mission is to help promote student achievement and excellence by ensuring equal access to education resources. 
             The entire data set spans nearly 20 years of data and covers a wide range of topics covering multiple sources.
             
             #Project Creators
             - Cecilia Vu (cdvu@uw.edu) 
             - Jody Tran (jtranx@uw.edu)
             - Rachel Vuu (rachvuu@uw.edu)
             - Mark Schteiden (mark1026@uw.edu)"
             sidebarPanel(
               sliderInput("grams",
                           "Minimum grams of sugar (g):",
                           min = -2,
                           max = 15,
                           value = 0),
               selectInput('colorvar', label = 'Variable to Color', choices = list("Manufacturer" = 'mfr', 'Type' = 'type'))
             ),
             mainPanel(
               # plotlyOutput('scatter')
             )
           )
  ),
  tabPanel("Race/Ethnicity in Washington",
    titlePanel("Race/Ethnicity Data"),
           sidebarLayout(
             sidebarPanel(
               selectInput('school', label = 'School:', choices=sort.state.data[,6]),
               sliderInput("year",
                           "Year",
                           min = 2000,
                           max = 2015,
                           value = 2015,
                           sep="")
             ),
             mainPanel(
               plotlyOutput('piechart')
             )
           )
  ),
  
  tabPanel("Financial Data in Washington",
     fluidPage(
       titlePanel("Financial Data"),
       
       # Create a new Row in the UI for selectInputs
       fluidRow(
         sliderInput("year",
                     "Select Year",
                     min = 2000,
                     max = 2015,
                     value = 2015,
                     sep="")
       ),
       
       # Create a new row for the table.
       fluidRow(
         dataTableOutput("finTable")
       )
     )
  )
)

shinyUI(my.ui)

