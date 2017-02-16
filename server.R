library(shiny)
library(forecast)
library(ggplot2)

series <- read.csv("DGS10.csv", stringsAsFactors = FALSE)

shinyServer(function(input, output) {
  
  series$DATE <- as.Date(series$DATE)
  series$DGS10 <- as.numeric(series$DGS10)
  
  timeseries <- ts(series$DGS10, 
                   start = c(2012,2,16), 
                   frequency = 365.25)
  
  
  
  output$distPlot <- renderPlot({
    model <- forecast(Arima(timeseries, order = c(input$AR,
                                                  input$DF,
                                                  input$MA)))
    plot(model)
    })
  
  output$modelData <- renderPrint({
    model <- Arima(timeseries, order = c(input$AR,
                                         input$DF,
                                         input$MA))
    model$coef
    })
})
