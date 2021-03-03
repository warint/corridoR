

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
#' @import dplyr
#' @import stringr
#' @import reshape2
#' @import magrittr
#' @import curl
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
  out <- data %>%
    dplyr::filter_all(any_vars(str_detect(., pattern = country)))  %>%
    dplyr::filter_all(any_vars(str_detect(., pattern = port)))


  return(out)
}


# Loading data
url <- paste0("https://warin.ca/datalake/corridoR/corridor_data.csv")
path <- file.path(tempdir(), "temp.csv")
curl::curl_download(url, path)
csv_file <- file.path(paste0(tempdir(), "/temp.csv"))
data <- readr::read_csv(csv_file)

# Creating the default values for the function query
# IF an entry is missing, all the observations of this variable will be displayed

data_long_country <- base::unique(data[,c(4,9,14,19)])

data_long_country <- reshape2::melt(data_long_country,measure.vars = colnames(data_long_country)[1:ncol(data_long_country)],
               variable.name = "var_indicator",
               value.name = "country_code")

data_long_country$var_indicator <- NULL
data_long_country <- base::unique(data_long_country)
country_code <- data_long_country$country_code


data_long_port <- base::unique(data[,c(2,7,12,17)])

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
#' If no argument is filed, all countries' ISO code will be displayed.
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
  
  if (missing(country)) {
    corridoR_countries_natural_language
  } else {
    corridoR_countries_natural_language[grep(country, corridoR_countries_natural_language$countryName, ignore.case = TRUE), ]
  }
}

# Loading data
url <- paste0("https://warin.ca/datalake/corridoR/corridor_countrycode.csv")
path <- file.path(tempdir(), "temp.csv")
curl::curl_download(url, path)
csv_file <- file.path(paste0(tempdir(), "/temp.csv"))
corridoR_countries_natural_language <- readr::read_csv(csv_file)


# Function 3
# If the user does not know the port's name included in the data, s.he has access to the answer in natural language through this query


#' corridor_port
#'
#' @description This function allows you to find and search port's name included in the Northern Corridor data. 
#' If no argument is filled, all ports included in the Northern Corridor data will be displayed.
#' 
#' @param port The name of the port
#'
#' @return Port's name included in the Northern Corridor data
#' @export
#'
#' @examples
#' myport <- corridor_port()
#' myport <- corridor_port(port = "HOUSTON")
#' myport <- corridor_port("HOUSTON")
#' 

corridor_port <- function(port) {
  
  if (missing(port)) {
    corridoR_ports_natural_language
  } else {
    corridoR_ports_natural_language[grep(port, corridoR_ports_natural_language$port, ignore.case = TRUE), ]
  }
}

pp1 <- unique(data[2:3])
colnames(pp1) <- c("port", "country")
pp2 <- unique(data[7:8])
colnames(pp2) <- c("port", "country")
np1 <- unique(data[12:13])
colnames(np1) <- c("port", "country")
np2 <- unique(data[17:18])
colnames(np2) <- c("port", "country")

corridoR_ports_natural_language <- dplyr::bind_rows(pp1, pp2)
corridoR_ports_natural_language <- dplyr::bind_rows(corridoR_ports_natural_language, np1)
corridoR_ports_natural_language <- dplyr::bind_rows(corridoR_ports_natural_language, np2)
corridoR_ports_natural_language <- unique(corridoR_ports_natural_language)

