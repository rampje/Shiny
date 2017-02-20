library(shiny)
library(forecast)
library(ggplot2)
library(httr)
library(httpuv)
library(jsonlite)
library(magrittr)
library(DT)

shinyServer(function(input, output, session) {
  
  # # function to get new data from api 
  GetData <- function(ticker){
    
    marketLink <- 
      paste0("https://www.predictit.org/api/marketdata/ticker/",ticker)
    
    marketContent <- httr::GET(marketLink)
    marketData <- httr::content(marketContent)
    marketData <- jsonlite::fromJSON(toJSON(marketData))
    marketData <- data.frame(marketData)
    
    keepCols <- c("Contracts.TickerSymbol",
                  "Contracts.LastTradePrice",
                  "TimeStamp")
    
    marketData <- marketData[keepCols]
    
    marketData$Contracts.TickerSymbol <- unlist(marketData$
                                                  Contracts.TickerSymbol)
    marketData$Contracts.LastTradePrice <- unlist(marketData$
                                                    Contracts.LastTradePrice)
    marketData$TimeStamp <- gsub("T"," ", marketData$TimeStamp)
    
    marketData$TimeStamp <- as.POSIXlt(marketData$TimeStamp)
    
    marketData
  }
  # initialize the table 
  serverData <<- GetData("VAGOV17")
  # function to update server data
  UpdateData <- function(){
    serverData <<- rbind(GetData("VAGOV17"), serverData)
  }
  
  
  output$serverData <- DT::renderDataTable({
    invalidateLater(60000, session) # 60 seconds
    UpdateData()
    serverData
    })

})
