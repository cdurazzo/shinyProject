library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(data.table)

# function(input, output){
#   #takes user input and creates text string to pass on to
#   formulaText <-reactive({
#     paste('crime ~',input$Variable)
#   })
#   
#   output$caption <-renderText({
#     formulaText()
#   })
#   
#   output$crime_plot <- renderPlot({
# 
#     ggplot(data = crime, aes(x = crime$boro_nm, y = crime$code)) +
#       geom_bar(stat = 'identity') +
#       labs(title = 'Crimes per Borough',
#            x = 'Borough',
#            y = 'Crime by desc code') +
#       scale_color_brewer(palette = 'Blues')
#     # leaflet(crime) %>%
#     #   addTiles() %>%
#     #   addMarkers(~longitude, ~latitude)
# 
#     # boxplot(as.formula(formulaText()),
#     #         data = as.data.frame(crime),
#     #         outline = input$outliers,
#     #         col = "#75AADB", pch = 19)
#   })
#   
# }

#choice <- unique(crime$code)



shinyServer(function(input, output) {
 
  output$mymap <- renderLeaflet({
    crime_filter = crime %>%
      filter(., ofns_desc == input$selected)
    
    leaflet(crime_filter) %>%
      addProviderTiles("Hydda.Full") %>% #Esri.WorldImagery, Hydda.Full
      addCircleMarkers(~longitude, ~latitude, opacity = 0.001, color = 'red', radius = 5)
  })
  
  output$clustermap <- renderLeaflet({
    leaflet(crime) %>%
      addTiles() %>%
      addProviderTiles("Hydda.Full") %>%
      addMarkers(~longitude, ~latitude, clusterOptions = markerClusterOptions())
  })
  
  output$graph <- renderPlot({
    ggplot(data = crime, aes(x = crime$boro_nm, y = crime$code)) +
      geom_bar(aes(fill = crime$boro_nm), stat = 'identity') +
      labs(title = 'Crimes per Borough',
           x = 'Borough',
           y = 'Crime by desc code')
  })
  
  output$mytable = DT::renderDataTable({
    crime_table
  })

}
)

