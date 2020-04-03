

#' corridoR
#'
#' @description This function allows you to find and display the Northern Corridor data according to the selected parameters.
#' The results come from a study conducted on the Nüance-R platform.
#' If no arguments are filled, all data will be displayed.
#'
#' @param country Countries' ISO code.
#' @param port Port's name
#'
#' @return Data for the country and port requested
#'
#' @export
#'
#' @import gsheet
#' @import dplyr
#' @import stringr
#' @import reshape2
#' @import magrittr
#'
#'
#' @examples
#' df <- corridor_data(country = "USA",port = "")
#' df <- corridor_data(country = "",port = "")
#' df <- corridor_data(country = "",port = "QUEBEC")
#'
#'
#'
#'
#'

# Function 1

corridor_data <- function(country = country_code,
                         port = port_name){
  out <- data_long %>%
    dplyr::filter_all(any_vars(str_detect(., pattern = country)))  %>%
    dplyr::filter_all(any_vars(str_detect(., pattern = port)))


  return(out)
}



data <- gsheet::gsheet2tbl("https://docs.google.com/spreadsheets/d/1Rz7h4HYUE3rmuiPHNJbHTdhsAjQrEDQfJB544zbZCrc/edit?usp=sharing")
data_long<- data


# Creating the default values for the function query
# IF an entry is missing, all the observations of this variable will be displayed

data_long_country <- base::unique(data_long[,c(4,9,14,19)])

data_long_country <- reshape2::melt(data_long_country,measure.vars = colnames(data_long_country)[1:ncol(data_long_country)],
               variable.name = "var_indicator",
               value.name = "country_code")

data_long_country$var_indicator <- NULL
data_long_country <- base::unique(data_long_country)
country_code <- data_long_country$country_code


data_long_port <- base::unique(data_long[,c(2,7,12,17)])

data_long_port <- reshape2::melt(data_long_port,measure.vars = colnames(data_long_port)[1:ncol(data_long_port)],
                                    variable.name = "var_indicator",
                                    value.name = "port_name")
data_long_port$var_indicator <- NULL
data_long_port <- base::unique(data_long_port)
port_name <- data_long_port$port_name

utils::globalVariables(c("."))

# Function 2
# If the user does not know the ISO code of a country, s.he has access to the answer in natural language through this query



#' corridor_country
#'
#' @description This function allows you to find and search the right country code associated with the Northern Corridor Data.
#' If no argument is filed, all indicators will be displayed.
#'
#'
#' @param country The name of the country
#'
#' @return Country's ISO code.
#' @export
#'
#' @examples
#'mycountry <- corridor_country()
#'mycountry <- corridor_country(country = "Canada")
#'mycountry <- corridor_country("Canada")
#'
corridor_country <- function(country) {
  corridoR_countries_natural_language <- gsheet::gsheet2tbl("https://docs.google.com/spreadsheets/d/1mo-FthNBeqDsm5-kGd--u4jMKVXxyf8CMbe7zHCf88Q/edit?usp=sharing")
  if (missing(country)) {
    corridoR_countries_natural_language
  } else {
    corridoR_countries_natural_language[grep(country, corridoR_countries_natural_language$countryName, ignore.case = TRUE), ]
  }
}



