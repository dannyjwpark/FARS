#  ----------------------------------------------------------------------------
#  COURSERA: BUILDING R PACKAGES
#  Peer-graded Assignment
#  File: fars_functions.R
#  (c) 2020 - Danny Park
#  email: danincali@gmail.com
#  GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007
#  ---------------------------------------------------------------------------
getwd()
list.files()

#' The functions provided for you in this assignment will be using data from the US National
#' Highway Traffic Safety Administration's Fatality Analysis Reporting System, which is a
#' nationwide census providing the American public yearly data regarding fatal injuries suffered
#' in motor vehicle traffic crashes.
#'
#' @details Fatality Analysis Reporting System:
#' \itemize{
#' \item{url{https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars}}
#' }
#'
#' importing necessary libraries
#'
#' @importFrom readr
#' @importFrom dplyr
#' @importFrom magrittr
#' @importFrom tidyr
#' @importFrom maps
#' @importFrom graphics
#'
#' listing parameters in the package
#'
#' @param filename Name of file to be read
#' @param years Vector of listed years
#' @param state.num An interger representing State Code i.e. 05 = California, 38 = Oregon
#'
#' fars_read
#' reading FARS data file
#'
#' \code{fars_read}
#' @export
fars_read <- function(filename) {
  if(!file.exists(filename))
    stop("file '", filename, "' does not exist")
  data <- suppressMessages({
    readr::read_csv(filename, progress = FALSE)
  })
  dplyr::tbl_df(data)
}

#' make_filename
#' make a data filenname
#'
#' There are 3 fatality analysis data tables of different years: 2013, 2014, 2015
#' Based on year #, .csv file can be generated
#' \code{make_filename}
#'
#' @examples
#' yr <- 2013
#' data <- yr %>%
#'   make_filename %>%
#'   fars_read
#' head(data)
#' make_filename(yr)
#'
#' @export
make_filename <- function(year) {
  year <- as.integer(year)
  sprintf("accident_%d.csv.bz2", year)
}

#'
#'fars_read_years
#'Read FARS years
#'
#' \code{fars_summarize_years}
#'  @return A data.frame with data by month, or
#'  NULL if \code{year} is not valid
#'
#'  @examples
#'  year <- 2014
#'  fars_read_years(year)
#' @export
fars_read_years <- function(years) {
  lapply(years, function(year) {
    file <- make_filename(year)
    tryCatch({
      dat <- fars_read(file)
      dplyr::mutate(dat, year = year) %>%
        dplyr::select(MONTH, year)
    }, error = function(e) {
      warning("invalid year: ", year)
      return(NULL)
    })
  })
}

#' fars_summarize_years
#' summarizing FARS data by years
#'
#' @examples
#' plot(fars_summarize_years(2015))
#' fars_summarize_years(c(2015,2014))
#'  @export
fars_summarize_years <- function(years) {
  dat_list <- fars_read_years(years)
  dplyr::bind_rows(dat_list) %>%
    dplyr::group_by(year, MONTH) %>%
    dplyr::summarize(n = n()) %>%
    tidyr::spread(year, n)
}

#' fars_map_state
#' Displaying maps of accidents that occured in each state at certain year
#'
#' Error occurs when \code{state.num} is invalid
#' @examples
#' fars_map_state(38, 2015)
#' plots accidents occured in Oregon on the year of 2015
#'
#' @export
fars_map_state <- function(state.num, year) {
  filename <- make_filename(year)
  data <- fars_read(filename)
  state.num <- as.integer(state.num)
  
  if(!(state.num %in% unique(data$STATE)))
    stop("invalid STATE number: ", state.num)
  data.sub <- dplyr::filter(data, STATE == state.num)
  if(nrow(data.sub) == 0L) {
    message("no accidents to plot")
    return(invisible(NULL))
  }
  is.na(data.sub$LONGITUD) <- data.sub$LONGITUD > 900
  is.na(data.sub$LATITUDE) <- data.sub$LATITUDE > 90
  with(data.sub, {
    maps::map("state", ylim = range(LATITUDE, na.rm = TRUE),
              xlim = range(LONGITUD, na.rm = TRUE))
    graphics::points(LONGITUD, LATITUDE, pch = 46)
  })
}
