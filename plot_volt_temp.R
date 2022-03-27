# Hans-Henrik Fuxelius 2022-03-27
# Plot voltage - temperature

library(DBI)
library("RSQLite")

con <- dbConnect(SQLite(), "default_creek_0006_20220327_0906.sqlite3")

as.data.frame(dbListTables(con)) # List all tables in SQLite database

volt <- dbReadTable(con, "ts_voltage")

volt$event_time
volt$voltage

startDate <- as.POSIXct("2022-03-21 00:00:00")
endDate <- as.POSIXct("2022-03-27 00:00:00")

tm <- as.POSIXct(volt$event_time)
plot(tm, volt$voltage, ylim=c(0.7,1.4), xlim=c(startDate, endDate), type="l", 
     col="red", xlab="time", ylab="Voltage", main="Voltage Plot")


dbDisconnect(con)
