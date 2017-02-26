# experiments with VAR models

library(vars)

first.date <- Sys.Date()-150
last.date <- Sys.Date()

tickers <- c("GSPC","AEP")

l.out <- BatchGetSymbols(tickers = tickers,
                         first.date = first.date,
                         last.date = last.date)

p <- ggplot(l.out$df.tickers, aes(x = ref.date, y = price.close))
p <- p + geom_line()
p <- p + facet_wrap(~ticker, scales = 'free_y') 
p


c1 <- l.out$df.tickers$price.close[l.out$df.tickers$ticker=="AEP"]
c2 <- l.out$df.tickers$volume[l.out$df.tickers$ticker=="AEP"]
c3 <- l.out$df.tickers$price.close[l.out$df.tickers$ticker=="GSPC"]

Y <- data.frame(c1,c2)

a <- VAR(Y)
summary(a)
fcsts <- predict(a)
fanchart(fcsts, color = "#3F8EFC", cis = 0.5,
         main = c("AEP Stock Closing Price","AEP Stock Trade Volume"))
