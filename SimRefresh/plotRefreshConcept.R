library(shiny)

ui <- shinyServer(fluidPage(
  plotOutput("livePlot")
))

server <- shinyServer(function(input, output, session){
  
  refreshData <- function(){
    new.data <- data[2:25]
    new.data[25] <- rnorm(1)
    data <<- new.data
  }
  
  data <- rnorm(25)
  
  output$livePlot <- renderPlot({
    invalidateLater(300, session)
    refreshData()
    plot(diffinv(data), type = "o")
  })
})

shinyApp(ui = ui, server = server)
