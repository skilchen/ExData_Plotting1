##
## file:     plot1.R 
## context:  coursera exploratory data analysis project 1
## author:   skilchen
## date:     Thursday, Aug 5, 2014
##

plot1 <- function(show=FALSE) {
  #
  # recreates the plot 1 at
  # https://github.com/skilchen/ExData_Plotting1/blob/master/figure/unnamed-chunk-2.png
  # stores the plot in "plot1.png" in the working directory
  #
  #
  # if called with parameter show=TRUE it tries to display the
  # created png file in a separate window
  #
  
  # load and prepare the data
  source("get_data.R", local=TRUE)
  data <- get_data()
  
  # plot file name
  png_file <- "plot1.png"
  
  # open png plot device with transparent background
  png(filename=png_file, bg=NA,
      width=480, height=480)
  
  # create the plot
  with(data, hist(Global_active_power,
                  main="Global Active Power",
                  xlab="Global Active Power (kilowatts)",
                  col="orangered3"))
  dev.off()
  
  if(show) {
    file.show(png_file)
  }
  
  invisible()
}

plot1()