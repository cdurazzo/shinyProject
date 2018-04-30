library(shiny)
library(data.table)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Map with Choices", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Cluster Map", tabName = "clustermap", icon = icon("map-marker")),
    menuItem("Graphs", tabName = "graphs", icon = icon("delicious")),
    menuItem("Full Dataset", icon = icon("database"), 
             href = 'https://data.cityofnewyork.us/Public-Safety/NYPD-Complaint-Data-Historic/qgea-i56i')
    
  )
)

body <- dashboardBody(
  tabItems(
    # First tab content
    tabItem(tabName = "dashboard",
            fluidRow(
              box(leafletOutput('mymap'), background = 'blue'),
              box(selectInput(inputId = "selected",
                          label = "Select Crime to display",
                          choices = unique(crime$ofns_desc), selected = 1), status = 'success', background = 'blue')
            )
    ),
    
    tabItem(tabName = "clustermap",
            fluidRow(
              box(leafletOutput('clustermap'), background = 'blue')
            )),
    
    tabItem(tabName = "graphs",
            fluidRow(
              box(plotOutput('graph'), background = 'blue')
            ))
    )
)
   

dashboardPage(
  dashboardHeader(title = 'NYC Crime Data'),
  sidebar,
  body
)
