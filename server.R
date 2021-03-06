library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(data.table)


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
      addMarkers(~longitude, ~latitude, clusterOptions = markerClusterOptions(), popup = crime$ofns_desc)
  })
  
  output$graph1 <- renderPlot({
    ggplot(data = crime, aes(x = crime$boro_nm, y = crime$code)) +
      geom_bar(aes(fill = crime$boro_nm), stat = 'identity') +
      labs(title = 'Crimes per Borough',
           x = 'Borough',
           y = 'Number of crimes occurred')+
      guides(fill=guide_legend(title="Borough Name"))
  })
  
  output$graph2 <- renderPlot({
    ggplot(data = pop_data, aes(x=pop_data$boro_nm, y=pop_data$pop_sm))+
      geom_bar(stat = 'identity', aes(fill =pop_data$boro_nm)) + 
      labs(title = 'Borough Population Per Square Mile',
           x = 'Borough',
           y = 'Population per square mile')+
      guides(fill=guide_legend(title="Borough Name"))
  })
  
  output$mytable = DT::renderDataTable({
    crime_table
  })

}
)

