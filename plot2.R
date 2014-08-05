##
## file:     plot2.R 
## context:  coursera exploratory data analysis project 1
## author:   skilchen
## date:     Thursday, Aug 5, 2014
##

plot2 <- function(show=FALSE) {
  #
  # recreates the plot 2 at
  # https://github.com/skilchen/ExData_Plotting1/blob/master/figure/unnamed-chunk-3.png
  # stores the plot in "plot2.png" in the working directory
  #
  # if called with parameter show=TRUE it tries to display the
  # created png file in a separate window
  #
  
  # load and prepare the data
  source("get_data.R")
  data <- get_data()
  
  # plot file name
  png_file <- "plot2.png"
  
  # to get the same labels on the x axis as the examples
  Sys.setlocale("LC_ALL", "english")
  
  # open png plot device with transparent background
  png(filename=png_file, bg=NA,
      width=480, height=480)
  
  # create the plot
  with(data, plot(DateTime, Global_active_power, type="l",
                  xlab=NA, ylab="Global Active Power (kilowatts"))
  dev.off()
  
  # restore locale settings
  Sys.setlocale()
  
  if(show) {
    file.show(png_file)
  }
  invisible()
}

plot2()