<!-- README.md is generated from README.Rmd. Please edit that file -->
wikilake
========

[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/wikilake)](https://cran.r-project.org/package=wikilake)

The `wikilake` package provides functions to scrape the metadata tables from lake pages on Wikipedia.

Installation
------------

`devtools::install_github("jsta/wikilake")`

Usage
-----

``` r
library(wikilake)
#> Loading required package: maps
```

``` r
# metadata only
lake_wiki("Lake Mendota")
#> Retrieving data from: https://en.wikipedia.org/wiki/Lake_Mendota
#>   Name                             Location Primary inflows
#> 1 Name Dane County, Wisconsin,United States    Yahara River
#>   Primary outflows      Catchment area Basin countries
#> 1     Yahara River 562 km2 (217 sq mi)   United States
#>                           Surface area Max. depth Residence time
#> 1 9,740 acres (3,940 ha) (39.4 sq. km)         25      4.5 years
#>       Shore length1 Surface elevation                              Frozen
#> 1 21.6 mi (34.8 km)    259 m (850 ft) December 20 (average freezing date)
#>       Lat      Lon
#> 1 43.1066 -89.4247
```

``` r
# metadata + map
lake_wiki("Lake Baikal", map = TRUE, "world")
#> Retrieving data from: https://en.wikipedia.org/wiki/Lake_Baikal
```

![](images/worldmapping-1.png)

    #>   Name        Location             Lake type
    #> 1 Name Siberia, Russia Continental rift lake
    #>                   Primary inflows Primary outflows
    #> 1 Selenge, Barguzin, Upper Angara           Angara
    #>                Catchment area     Basin countries     Max. length
    #> 1 560,000 km2 (216,000 sq mi) Russia and Mongolia 636 km (395 mi)
    #>      Max. width                 Surface area Average depth Max. depth
    #> 1 79 km (49 mi) 31,722 km2 (12,248 sq mi)[1]          <NA>       <NA>
    #>                     Water volume Residence time       Shore length1
    #> 1 23,615.39 km3 (5,700 cu mi)[1]   330 years[2] 2,100 km (1,300 mi)
    #>    Surface elevation      Frozen    Type         Criteria
    #> 1 455.5 m (1,494 ft) January-May Natural vii, viii, ix, x
    #>            Designated Reference no. State Party Region  Lat Lon
    #> 1 1996 (22nd session)           754      Russia   Asia 53.5 108

``` r
lake_wiki("Lake Mendota", map = TRUE, "usa")
#> Retrieving data from: https://en.wikipedia.org/wiki/Lake_Mendota
```

![](images/mapping-1.png)

    #>   Name                             Location Primary inflows
    #> 1 Name Dane County, Wisconsin,United States    Yahara River
    #>   Primary outflows      Catchment area Basin countries
    #> 1     Yahara River 562 km2 (217 sq mi)   United States
    #>                           Surface area Max. depth Residence time
    #> 1 9,740 acres (3,940 ha) (39.4 sq. km)         25      4.5 years
    #>       Shore length1 Surface elevation                              Frozen
    #> 1 21.6 mi (34.8 km)    259 m (850 ft) December 20 (average freezing date)
    #>       Lat      Lon
    #> 1 43.1066 -89.4247

``` r
lake_wiki("Lake Nipigon", map = TRUE, regions = "Canada")
#> Retrieving data from: https://en.wikipedia.org/wiki/Lake_Nipigon
```

![](images/mapping2-1.png)

    #>   Name Location Primary outflows              Catchment area
    #> 1 Name  Ontario    Nipigon River 25,400 km2 (9,800 sq mi)[1]
    #>   Basin countries            Surface area Average depth Max. depth
    #> 1          Canada 4,848 km2 (1,872 sq mi)          <NA>       <NA>
    #>              Water volume Shore length1 Surface elevation   Lat   Lon
    #> 1 248 km3 (59.5 cu mi)[2]   1044 km [2]    260 m (850 ft) 49.83 -88.5

``` r
lake_wiki("Cass Lake (Michigan)", map = TRUE, "state", region = "Michigan")
#> Retrieving data from: https://en.wikipedia.org/wiki/Cass_Lake_(Michigan)
```

![](images/mapping3-1.png)

    #>   Name                 Location Basin countries         Surface area
    #> 1 Name Oakland County, Michigan   United States 1,280 acres (520 ha)
    #>   Max. depth   Surface elevation    Lat     Lon
    #> 1         37 928 feet (283 m)[1] 42.606 -83.365
