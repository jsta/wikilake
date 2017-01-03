<!-- README.md is generated from README.Rmd. Please edit that file -->
wikilake
========

The `wikilake` package provides functions to scrape the metadata tables from lake pages on Wikipedia.

Installation
------------

`devtools::install_github("jsta/wikilake")`

Usage
-----

``` r
library(wikilake)
#> Loading required package: maps
library(maps)
```

``` r
# metadata only
knitr::kable(lake_wiki("Lake Mendota"))
#> Retrieving data from: https://en.wikipedia.org/wiki/Lake_Mendota
```

| Name         | Location                             | Primary inflows | Primary outflows | Catchment area      | Basin countries | Surface area                         | Max. depth   | Residence time | Shore length1     | Surface elevation | Frozen                              |      Lat|       Lon|
|:-------------|:-------------------------------------|:----------------|:-----------------|:--------------------|:----------------|:-------------------------------------|:-------------|:---------------|:------------------|:------------------|:------------------------------------|--------:|---------:|
| Lake Mendota | Dane County, Wisconsin,United States | Yahara River    | Yahara River     | 562 km2 (217 sq mi) | United States   | 9,740 acres (3,940 ha) (39.4 sq. km) | 83 ft (25 m) | 4.5 years      | 21.6 mi (34.8 km) | 259 m (850 ft)    | December 20 (average freezing date) |  43.1066|  -89.4247|

``` r
# metadata + map
lake_wiki("Lake Mendota", map = TRUE, "usa")
#> Retrieving data from: https://en.wikipedia.org/wiki/Lake_Mendota
```

![](images/mapping-1.png)

    #>           Name                             Location Primary inflows
    #> 1 Lake Mendota Dane County, Wisconsin,United States    Yahara River
    #>   Primary outflows      Catchment area Basin countries
    #> 1     Yahara River 562 km2 (217 sq mi)   United States
    #>                           Surface area   Max. depth Residence time
    #> 1 9,740 acres (3,940 ha) (39.4 sq. km) 83 ft (25 m)      4.5 years
    #>       Shore length1 Surface elevation                              Frozen
    #> 1 21.6 mi (34.8 km)    259 m (850 ft) December 20 (average freezing date)
    #>       Lat      Lon
    #> 1 43.1066 -89.4247

``` r
lake_wiki("Lake Nipigon", map = TRUE, regions = "Canada")
#> Retrieving data from: https://en.wikipedia.org/wiki/Lake_Nipigon
```

![](images/mapping2-1.png)

    #>           Name Location Primary outflows              Catchment area
    #> 1 Lake Nipigon  Ontario    Nipigon River 25,400 km2 (9,800 sq mi)[1]
    #>   Basin countries            Surface area      Average depth
    #> 1          Canada 4,848 km2 (1,872 sq mi) 54.9 m (180 ft)[2]
    #>       Max. depth            Water volume Shore length1 Surface elevation
    #> 1 165 m (541 ft) 248 km3 (59.5 cu mi)[2]   1044 km [2]    260 m (850 ft)
    #>     Lat   Lon
    #> 1 49.83 -88.5
