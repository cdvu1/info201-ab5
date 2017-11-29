library(shiny)
library(plotly)


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
  )
)

shinyUI(my.ui)

