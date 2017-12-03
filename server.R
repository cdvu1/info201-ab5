#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
# library(DT)
source("scripts/financial.R")
source("scripts/ethnicity.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2] 
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
    
  })
  
  output$finTable <- renderDataTable(state.data)
  
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
