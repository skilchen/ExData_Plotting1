##
## file:     plot4.R 
## context:  coursera exploratory data analysis project 1
## author:   skilchen
## date:     Thursday, Aug 5, 2014
##

plot4 <- function(show=FALSE) {
  #
  # recreates the plot 4 at
  # https://github.com/skilchen/ExData_Plotting1/blob/master/figure/unnamed-chunk-5.png
  # stores the plot as "plot4.png" in the working directory
  #
  # if called with parameter show=TRUE it tries to display the
  # created png file in a separate window
  #
  
  # load and prepare the data
  source("get_data.R", local=TRUE)
  data <- get_data()
  
  # plot file name
  png_file <- "plot4.png"
  
  # to get the same labels on the x axis as the examples
  Sys.setlocale("LC_ALL", "english")
  
  # open png plot device with transparent background
  png(filename=png_file, bg=NA,
      width=480, height=480)
  
  # create a 2*2 matrix of plots
  opar <- par(mfrow=c(2, 2))  
  
  with(data, {
    # first subplot
    plot(DateTime, Global_active_power, type="l",
         xlab=NA, ylab="Global Active Power (kilowatts")
    
    # second subplot
    plot(DateTime, Voltage,
         xlab="datetime",
         ylab="Voltage",
         type="l")
    
    # third subplot
    plot(DateTime, Sub_metering_1, type="l",
         xlab=NA,
         ylab="Energy sub metering", 
         col="black")     
    lines(DateTime, Sub_metering_2, col="red")         
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright", legend=c("Sub_metering_1",
                                "Sub_metering_2",
                                "Sub_metering_3"),
           col=c("black", "red", "blue"), lty=1)
    
    # fourth subplot
    plot(DateTime, Global_reactive_power,
         xlab="datetime",
         type="l", col="black")
    
  })
  dev.off()
  
  # restore plotting parameters
  par(opar)
  # restore locale settings
  Sys.setlocale()
  
  if(show) {
    file.show(png_file)
  }
  
  invisible()
}

plot4()