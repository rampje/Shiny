
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Time series with forecast package"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      numericInput(inputId="AR",
                   label="Auto Regressive terms",
                   min = 0,
                   max = 3,
                   value = 1),
      numericInput(inputId="MA",
                   label="Moving Average terms",
                   min = 0,
                   max = 3,
                   value = 1),
      numericInput(inputId="DF",
                   label="Differencing",
                   min = 0, 
                   max = 3,
                   value = 0),
      verbatimTextOutput("modelData")
    
    ),
    
    

    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))
