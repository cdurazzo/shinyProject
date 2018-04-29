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
      filter(., code == input$selected)
    
    leaflet(crime_filter) %>%
      addProviderTiles("Esri.WorldStreetMap") %>%
      addCircles(~longitude, ~latitude)
  })
}
)