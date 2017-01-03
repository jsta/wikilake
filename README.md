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
library(maps)
```

``` r
# metadata only
lake_wiki("Lake Mendota")
#> Retrieving data from: https://en.wikipedia.org/wiki/Lake_Mendota
#>         Lake Mendota                         Lake Mendota
#> 2           Location Dane County, Wisconsin,United States
#> 3        Coordinates                   43.10667,-89.42472
#> 4    Primary inflows                         Yahara River
#> 5   Primary outflows                         Yahara River
#> 6     Catchment area                  562 km2 (217 sq mi)
#> 7    Basin countries                        United States
#> 9       Surface area 9,740 acres (3,940 ha) (39.4 sq. km)
#> 10        Max. depth                         83 ft (25 m)
#> 11    Residence time                            4.5 years
#> 12     Shore length1                    21.6 mi (34.8 km)
#> 13 Surface elevation                       259 m (850 ft)
#> 15            Frozen  December 20 (average freezing date)
```

``` r
# metadata + map
lake_wiki("Lake Mendota", map = TRUE, "usa")
#> Retrieving data from: https://en.wikipedia.org/wiki/Lake_Mendota
```

![](images/mapping-1.png)

    #>         Lake Mendota                         Lake Mendota
    #> 2           Location Dane County, Wisconsin,United States
    #> 3        Coordinates                   43.10667,-89.42472
    #> 4    Primary inflows                         Yahara River
    #> 5   Primary outflows                         Yahara River
    #> 6     Catchment area                  562 km2 (217 sq mi)
    #> 7    Basin countries                        United States
    #> 9       Surface area 9,740 acres (3,940 ha) (39.4 sq. km)
    #> 10        Max. depth                         83 ft (25 m)
    #> 11    Residence time                            4.5 years
    #> 12     Shore length1                    21.6 mi (34.8 km)
    #> 13 Surface elevation                       259 m (850 ft)
    #> 15            Frozen  December 20 (average freezing date)

``` r
lake_wiki("Lake Nipigon", map = TRUE, regions = "Canada")
#> Retrieving data from: https://en.wikipedia.org/wiki/Lake_Nipigon
```

![](images/mapping%202-1.png)

    #>         Lake Nipigon                Lake Nipigon
    #> 2           Location                     Ontario
    #> 3        Coordinates                49.833,-88.5
    #> 4   Primary outflows               Nipigon River
    #> 5     Catchment area 25,400 km2 (9,800 sq mi)[1]
    #> 6    Basin countries                      Canada
    #> 8       Surface area     4,848 km2 (1,872 sq mi)
    #> 9      Average depth          54.9 m (180 ft)[2]
    #> 10        Max. depth              165 m (541 ft)
    #> 11      Water volume     248 km3 (59.5 cu mi)[2]
    #> 12     Shore length1                 1044 km [2]
    #> 13 Surface elevation              260 m (850 ft)
