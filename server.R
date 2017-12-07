library(shiny)
library(plotly)
library(dplyr)
library(RColorBrewer)

source("./scripts/financial.R")
source("./scripts/ethnicity.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  #Financial Data Table
  output$finTable <- renderDataTable(GetFinData(input$year))
  
    #Map of Schools
   output$map <- renderPlotly ({
   saved.data <- read.csv('map.data.csv')
     
     map.data <- saved.data %>%
       filter(as.numeric(admissions) <= as.numeric(input$admissions))
     
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
     
     plot.interactive.map <- plot_geo(map.data, lat = ~lat, lon = ~long) %>%
       add_markers(
         text = ~paste(paste('School Name:', name), paste('City:', city), paste('Acceptance Rate:', admissions), paste('First Generation Student Percentage:', firstgen), sep = "<br />"),
         color = ~admissions, symbol = I("square"), size = I(4), hoverinfo = "text"
       ) %>%
       colorbar(title = "Acceptance Rate") %>%
       layout(
         title = 'Colleges Across the Country<br />(Hover For More Info)', geo = g
       )
   })
   
  output$piechart <- renderPlotly({
    pie.data <- GetRaceData(input$year) %>%
      filter(school.name == input$school)
    row.list <- unname(unlist(pie.data[1,]))
    data.frame(t(row.list))
    
    # Make chart
    plot_ly(pie.data, labels = ~colnames(pie.data), values = ~row.list, type = 'pie',
            marker = list(colors = colorRampPalette(brewer.pal(12, "Set3"))(100))) %>%
      layout(title = "Percentages by Race",  showlegend = F,
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)) 
  })
})
