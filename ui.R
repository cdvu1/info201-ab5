library(shiny)
library(plotly)
library(shinythemes)

source("./scripts/ethnicity.R")
source("./scripts/financial.R")
my.ui <- navbarPage(
  theme = shinytheme('superhero'),
  # Application Title
  "College Data", 
  tabPanel("Home",
      mainPanel(
        h2("Overview"),
        p("Applying for colleges for the very first time can be hard and sometimes you don't know what are the best options out there.
           Especially if you are a first-generation student. There are many choices of universities all over the U.S so choosing the 
           one that that best fits you can be difficult with so many options."),
        hr(),
        h3("Purpose"),
        p("This application was written for college applicants to use. Researching college information and statistics is a lengthy and 
          stressful process. In order to help these students who are going through this process, we have selected data such as demographic 
          information, financial/tution rates, etc in the Washington state. We represent these visually in this interactive web application."),
        hr(),
        h3("Data Source"),
        p("The dataset our group decided to work with was the College Scorecard’s data. This dataset was created by the United States department
          of education where their mission is to help promote student achievement and excellence by ensuring equal access to education resources. 
          The entire data set spans nearly 20 years of data and covers a wide range of topics covering multiple sources."),
        a("College Scorecard Link", href="https://collegescorecard.ed.gov/data/documentation/")
      )
  ),
  
  tabPanel("Map",
           sidebarLayout(
             sidebarPanel(
               helpText("Filter colleges across the U.S by acceptance rate"),
               sliderInput("admissions",
                           "Admissions Rate of Universities in the U.S:",
                           min = 0,
                           max = 100,
                           value = 100,
                           sep = "")
             ),
             mainPanel(
              plotlyOutput('map')
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
         sliderInput("fin.year",
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
  ),
  
  tabPanel("Contact Us",
    mainPanel(
      h1("Project Creators"),
      hr(),
      a("• Cecilia Vu", href="mailto:cdvu@uw.edu"),
      br(),
      a("• Jody Tran", href="mailto:jtranx@uw.edu"),
      br(),
      a("• Rachel Vuu", href="mailto:rachvuu@uw.edu"),
      br(),
      a("• Mark Schteiden", href="mailto:mark1026@uw.edu")
    )
  )
)  

shinyUI(my.ui)

