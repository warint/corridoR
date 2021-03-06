
<!-- README.md is generated from README.Rmd. Please edit that file -->

# corridoR

<!-- badges: start -->
<!-- badges: end -->

## Overview

Although maritime transport has lost its importance for the transport of
people, it has become the most important mode of transport for goods.
Indeed, approximately 80% of global merchandise is traded by sea. As an
essential part of international trade, commercial shipping relies on
strategic trade routes to move goods efficiently.

corridoR is an R wrapper to illustrate the reality of world maritime
trade by offering researchers and students access to real maritime
distances between the different major ports of the planet. Too often,
distances are calculated as the crow flies, but CorridoR uses existing
sea routes to make its calculations.

The corridoR project was also developed to analyze the potential impact
of the Northern Corridor on the Canadian economy and global maritime
traffic. We took more than 20 000 ship voyages passing through the
Panama Canal and calculated their marine distances.

To analyze the applicability and the profitability of the Canadian
Northwest Passage, we took the same 20 000 routes and make them passed
hypothetically through the Canadian Arctic. We then compared the
distances to see which trips were shorter by the Northern Corridor.
Distances are in nautical miles.

## Data Summary

The data are divided as follows:

`MMSI`: The numerical code associated with each ship voyages.

`Previous_Port1`: The name of the first port of the trip (PP1).

`Previous_Port2`: The name of the second port of the trip (PP2).

`Next_Port1`: The name of the third port of the trip (NP1).

`Next_Port2`: The name of the fourth port of the trip (NP2).

`Country`: The country associated to the each port (PP1,PP2,NP1,NP2).

`ISO`: Country’s ISO code for each port (PP1,PP2,NP1,NP2).

`Longitude and Latitude`: for each port.

`Distance_PA`: Distance calculated for ships passing through the Panama
Canal.

`Distance_PA_PP1toPP2`: Distance between Previous\_Port1 and
Previous\_Port2. Same logic applies for other ports.

`Distance_PA_Total`: Total distance for a selected ship voyage through
Panama Canal.

`Distance_NC`: Distance calculated for ships passing through the
Northern Corridor.

`Distance_NC_PP1toPP2`: Distance between Previous\_Port1 and
Previous\_Port2. Same logic applies for other ports.

`Distance_NC_Total`: Total distance for a selected ship voyage through
the Northern Corridor.

`Distance_Analysys`: Distance\_NC\_Total minus Distance\_PA\_Total to
analyse the shortest distance. If the value is negative, th Northern
Corridor is shorter

# Practical usage

## Quick start

First, install corridoR:

``` r
devtools::install_github("warint/corridoR")
```

Next, call corridoR to make sure everything is installed correctly.

``` r
library(corridoR)
```

## How-To

### Step 1: Getting the country’s ISO code

A user needs to enter the ISO code of a country. To have access to this
code, the following function provides this information.

``` r
corridor_country() # A list of all countries ISO code will be produced

corridor_country(country = "Canada") # The ISO code for Canada will be produced

corridor_country("Canada") # The ISO code for Canada will be produced
```

### Step 2: Getting the port’s name

To have access to the ports included in the data, the following function
provides this information.

``` r
corridor_port() # A list of all existing ports will be produced

corridor_port(country = "HOUS") # The port's name containing HOUS will be produced

corridor_port("HOUSTON") # The port's name containing HOUS will be produced
```

### Step 3: Getting the data

Once the user knows the ISO code , s.he can collect the data in a very
easy way through this function:

Be careful, you must put the empty arguments ("") to collect the data!

``` r
corridor_data() # It generates a data frame of the complete dataset

corridor_data(country = "CAN") # It generates a data frame of all the ships voyages containing a Canadian port

corridor_data(port = "QUEBEC") # It generates a data frame of all the ships voyages containing Houston.

corridor_data(country = "CAN", port = "QUEBEC") # It generates a data frame of all the ships voyages containing the country Canada and the port Quebec.
```

### Acknowledgments

The author would like to thank the Center for Interuniversity Research
and Analysis of Organizations (CIRANO, Montreal) for its support, as
well as Thibault Senegas, Marine Leroi and Martin Paquette. The usual
caveats apply.
