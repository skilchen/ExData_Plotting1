##
## file:     plot3.R 
## context:  coursera exploratory data analysis project 1
## author:   skilchen
## date:     Thursday, Aug 5, 2014
##

plot3 <- function(show=FALSE) {
  #
  # recreates the plot 3 at
  # https://github.com/skilchen/ExData_Plotting1/blob/master/figure/unnamed-chunk-4.png
  # stores the plot in "plot3.png" in the working directory
  #
  # if called with parameter show=TRUE it tries to display the
  # created png file in a separate window
  #
  
  # load and prepare the data
  source("get_data.R")
  data <- get_data()
  
  # plot file name
  png_file <- "plot3.png"
  
  # to get the same labels on the x axis as the examples
  Sys.setlocale("LC_ALL", "english")
  
  # open png plot device with transparent background
  png(filename=png_file, bg=NA,
      width=480, height=480)
  
  # create the plot
  with(data, {
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
    
  })
  dev.off()
  
  # restore locale settings
  Sys.setlocale()
  
  if(show) {
    file.show(png_file)
  }
  invisible()
}

plot3()