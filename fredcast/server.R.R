# install.packages("devtools")
devtools::install_github("sboysel/fredr")

library(fredr)

fredr_key("0e510a57a0086df706ac9c8fb852b706")

unemp <- fredr_series(series_id = "UNRATE")
gdp <- fredr_series(series_id = "A191RL1Q225SBEA")
payroll <- fredr_series(series_id = "PAYEMS")
cpi <- fredr_series(series_id = "CPIAUCSL")
