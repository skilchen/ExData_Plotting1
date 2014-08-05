##
## file:     get_data.R 
## context:  coursera exploratory data analysis project 1
## author:   skilchen
## date:     Thursday, Aug 5, 2014
##

download_and_unzip_data <- function(download_dir) {
  #
  # downloads the data from the url in the course project description
  # and unzips the data into download_dir
  # you need write permissions in download_dir
  # 
  message(date(), " start download_and_unzip_data")
  
  url <- 'https://kd396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  dest_file  <- file.path(download_dir, "household_power_consumption.zip")
  data_file <- file.path(download_dir, "household_power_consumption.txt")
  
  if (!file.exists(download_dir)) {
    if(!dir.create(download_dir, recursive=TRUE)) {
      stop("can't create ", download_dir)
    }
  }
  
  if (!file.exists(dest_file)) {
    if(download.file(url=url, destfile=dest_file, method="curl")) {
      stop("download from: ", url, " to: ", dest_file, " failed")
    }
  }
  
  if (!file.exists(data_file)) {
    x <- unzip(dest_file, exdir=download_dir, overwrite=TRUE)
    if(length(x) == 0) {
      stop("failed to unzip: ", dest_file)
    }
  }
  message(date(), " end   download_and_unzip_data")
}

filter_relevant_data <- function(input_file, filter_regexp="^[12]/2/2007") {
  #
  # reads the downloaded and unzipped input_file and
  # writes the lines matching filter_regexp (default as given
  # in the course project description) to a temporary file 
  # and then reads this temporary file into a data.frame 
  # and finally adds a DateTime column to the data.frame
  #
  # returns the data.frame 
  #
  ifp <- file(input_file, open="r")
  temp_name <- tempfile(pattern="filtered_data", fileext = ".txt")
  ofp <- file(temp_name, open="w")
  
  header <- readLines(ifp, n=1, warn=FALSE)
  cat(header, file=ofp)
  cat("\n", file=ofp)
  
  pattern_seen <- FALSE
  while(length(one_line <- readLines(ifp, n = 1, warn = FALSE)) > 0) {
    if(grepl(filter_regexp, one_line)) {
      pattern_seen <- TRUE
      cat(one_line, file=ofp)
      cat("\n", file=ofp)
    }
    else if(pattern_seen) {
      break
    }
  }
  close(ifp)
  close(ofp)

  data <- read.table(temp_name, header=TRUE, sep=";", na.strings="?",
                     stringsAsFactors=FALSE)  
  data$DateTime <- with(data, 
                        strptime(paste(Date, Time), "%d/%m/%Y %H:%M:%S"))
  unlink(temp_name)
  return(data)
}

get_data <- function() {
  #
  # driver function to download, unzip and prepare
  # the data required to produce the plots for the
  # course project
  #
  
  # where to store and unzip the data
  data_dir <- "./data"
  
  # the name of the file in the downloaded zip file
  data_file <- "household_power_consumption.txt"
  
  full_name <- file.path(data_dir, data_file)
  if(!(file.exists(full_name))) {
    tryCatch(download_and_unzip_data(data_dir), error = function(e) {
      stop(e)
    })
  }
  
  # regexp to filter the first two days in february 2007
  filter_regexp <- "^[12]/2/2007"
  
  data <- filter_relevant_data(full_name, filter_regexp)
  return(data)
}



