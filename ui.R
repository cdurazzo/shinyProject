library(shiny)
library(data.table)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Full Dataset", icon = icon("file-code-o"), 
             href = 'https://data.cityofnewyork.us/Public-Safety/NYPD-Complaint-Data-Historic/qgea-i56i'),
    selectInput(inputId = "selected",
                   label = "Select Crime to display",
                   choices = unique(crime$code), selected = 1)
  )
)

body <- dashboardBody(
  tabItems(
    # First tab content
    tabItem(tabName = "dashboard",
            fluidRow(
              box(leafletOutput('mymap'))
            )
    )
    )
)
   

dashboardPage(
  dashboardHeader(title = 'NYC Crime Data'),
  sidebar,
  body
)
