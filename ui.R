library(shiny)
library(data.table)

sidebar <- dashboardSidebar(
  sidebarUserPanel(name = 'Chris Durazzo', image = 'https://media.licdn.com/dms/image/C5603AQHMHXmknX2EUQ/profile-displayphoto-shrink_200_200/0?e=1530392400&v=beta&t=JSoKewnQmQp-llozUjwrVTCzez5W8MY1PE3vulwRbqw'),
  sidebarMenu(
    menuItem("Selection Map", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Cluster Map", tabName = "clustermap", icon = icon("map-marker")),
    menuItem("Graphs", tabName = "graphs", icon = icon("delicious")),
    menuItem("Data", tabName = "dt", icon = icon("file")),
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
              box(leafletOutput('clustermap'), background = 'blue',width = 8)
            )),
    
    tabItem(tabName = "graphs",
            fluidRow(
              box(plotOutput('graph1'), background = 'blue'),
              box(plotOutput('graph2'), background = 'blue')
            )),
    
    tabItem(tabName = "dt",
            DT::dataTableOutput("mytable"))
    )
)
   

dashboardPage(
  dashboardHeader(title = 'NYC Crime Data'),
  sidebar,
  body
)
