#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source("./scripts/financial.R")
#source("./scripts/ethnicity.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  #Financial Data Table
  output$finTable <- renderDataTable(GetData(input$year))
  
  # Rachel pie chart place holder
  output$scatter <- renderPlotly({
    chart.data <- cereal.data %>% 
      filter(as.numeric(sugars) > as.numeric(input$grams))
    
    # Make chart
    plot_ly(x = chart.data$sugars, 
            y = as.numeric(chart.data$rating),
            color = chart.data[,input$colorvar],
            hoverinfo = "text", text = ~paste(chart.data$name, "<br /> Sugar (g):", chart.data$sugars, "<br /> Rating:", chart.data$rating),
            type="scatter") %>% 
      layout(title = 'Cereal Data', xaxis=list(title="Sugar (g)"), yaxis=list(title="Rating")) 
  })
})
