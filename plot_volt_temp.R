# Hans-Henrik Fuxelius 2022-03-27
# Plot voltage - temperature

library(DBI)
library("RSQLite")

con <- dbConnect(SQLite(), "udtja_0006_20220315_0811.sqlite3")

as.data.frame(dbListTables(con)) # List all tables in SQLite database

volt <- dbReadTable(con, "ts_voltage")

volt$event_time
volt$voltage

startDate <- as.POSIXct("2022-03-10 00:00:00")
endDate <- as.POSIXct("2022-03-16 00:00:00")

tm <- as.POSIXct(volt$event_time)
plot(tm, volt$voltage, ylim=c(0.7,1.4), xlim=c(startDate, endDate), type="l", 
     col="blue", xlab="time", ylab="Voltage", main="Voltage-Temperature Plot")

par(new=TRUE)

temp <- dbReadTable(con, "ts_temperature")

tm2 <- as.POSIXct(temp$event_time)

plot(tm2, temp$temperature - 0.1, ylim=c(-20,60), xlim=c(startDate, endDate), type="l", 
     col="red", xlab="time", ylab="Voltage", axes=FALSE)

## Add Legend
legend("topright",legend=c("Voltage","Temperature"),
       text.col=c("blue","red"),pch=c(16,15),col=c("blue","red"))

## Draw temperature axis
mtext("Temperature",side=4,col="red",line=4) 
axis(4, ylim=c(0,20), col="red",col.axis="red",las=1)

dbDisconnect(con)

