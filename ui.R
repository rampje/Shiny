library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Streaming PredictIt Data"),

  # Sidebar with a slider input for number of bins
  mainPanel(
     verbatimTextOutput("tableInfo"),
     DT::dataTableOutput("serverData")
    )
  )
)

