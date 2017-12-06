library(shiny)
library(plotly)
source("./scripts/ethnicity.R")
source("./scripts/financial.R")
my.ui <- navbarPage(
  
  # Application Title
  "College Data", 
  tabPanel("Home",
           sidebarLayout(
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
  tabPanel("Map",
           sidebarLayout(
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
           sidebarLayout(
             sidebarPanel(
               selectInput('school', label = 'School:', choices=state.data[,6]),
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

