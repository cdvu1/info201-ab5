library(shiny)
library(plotly)
<<<<<<< HEAD
# library(DT)
=======
>>>>>>> cfbe7cf782e5ff35b153f816ad0ace20cc63f45b


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
               selectInput('colorvar', label = 'State', choices = list("Manufacturer" = 'mfr', 'Type' = 'type')),
               sliderInput("grams",
                           "Year",
                           min = 2000,
                           max = 2015,
                           value = 0, sep="")
             ),
             mainPanel(
               # plotlyOutput('scatter')
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

