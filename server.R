#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
source("./scripts/financial.R")
#source("./scripts/ethnicity.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  #Financial Data Table
  output$finTable <- renderDataTable(GetData(input$year))
  
  #Map of Schools.
  output$map <- renderPlotly {(
    
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showland = TRUE,
    landcolor = toRGB("gray95"),
    subunitcolor = toRGB("gray25"),
    countrycolor = toRGB("gray85"),
    countrywidth = 0.5,
    subunitwidth = 0.5
    )
  
  plot.interactive.map <- plot_geo(overview.data, lat = ~lat, lon = ~lng) %>%
    add_markers(
      text = ~paste(date, paste('School Name:', name), paste('City:', city), paste('State:', state), paste('Injured:', injured), paste('Casualties:', casualties), sep = "<br />"),
      color = ~acceptancerate, symbol = I("square"), size = I(6), hoverinfo = "text"
    ) %>%
    colorbar(title = "Acceptance Rate") %>%
    layout(
      title = 'Colleges Across the Country<br />(Hover For More Info)', geo = g
    )
  
  )}
  
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
