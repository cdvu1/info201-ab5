library(shiny)
library(plotly)
library(DT)


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
               plotlyOutput('scatter')
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
               plotlyOutput('scatter')
             )
           )
  ),
  tabPanel("Race/Ethnicity in Washington",
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
               plotlyOutput('scatter')
             )
           )
  ),
  tabPanel("Financial Data in Washington",
     fluidPage(
       titlePanel("Cost of Tuition"),
       
       # Create a new Row in the UI for selectInputs
       fluidRow(
         sliderInput("year",
                     "Financial data in the year:",
                     min = 2000,
                     max = 2015,
                     value = 2015)
       ),
       
       # Create a new row for the table.
       fluidRow(
         dataTableOutput("finTable")
       )
     )
  )
)

shinyUI(my.ui)

