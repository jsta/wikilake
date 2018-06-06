# https://en.wikipedia.org/wiki/Template:Infobox_body_of_water

# specify default units
unit_key_ <- function(){
  unit_key <-
    "Variable, format, units\n
    Name, c, NA\n
    Location, c, NA\n
    Group, ?, NA\n
    Coordinates, ?, NA\n
    Type, ?, NA\n
    Etymology, ?, NA\n
    Part of, ?, NA\n
    Primary inflows, ?, NA\n
    River sources, ?, NA\n
    Primary outflows, ?, NA\n
    Ocean/sea sources, ?, NA\n
    Catchment area, n, km2\n
    Basin countries, ?, NA\n
    Managing agency, ?, NA\n
    Designation, ?, NA\n
    Built, ?, NA\n
    Construction engineer, ?, NA\n
    First flooded, ?, NA\n
    Max. length, n, km\n
    Max. width, n, km\n
    Surface area, n, km2\n
    Average depth, n, m\n
    Max. depth, n, m\n
    Water volume, n, m3\n
    Residence time, n, NA\n
    Salinity, n, NA\n
    Shore length1, n, km\n
    Surface elevation, n, m\n
    Max. temperature, n, NA\n
    Min. temperature, n, NA\n
    Frozen, ?, NA\n
    Islands, ?, NA\n
    Sections/sub-basins, ?, NA\n
    Trenches, ?, NA\n
    Benches, ?, NA\n
    Settlements, ?, NA\n
    Website, ?, NA\n
    References, ?, NA"

  read.csv(textConnection(unit_key), stringsAsFactors = FALSE,
           strip.white = TRUE, sep = ",")
}

tidy_units <- function(res){
  unit_key <- unit_key_()

  known_units <- c("m", "km2", "years", "sq mi", "ha", "m3", "acres", "sq. km")

  numeric_cols <- unit_key$Variable[unit_key$format == "n"]
  numeric_cols <- names(res) %in% numeric_cols
  numeric_cols <- names(res)[numeric_cols]

  if(length(numeric_cols) == 0){
    res
  }else{
    specified_cols    <- apply(res, 2,
                                function(x) any(
                                  stringr::str_detect(x, known_units)))
    specified_cols    <- names(res)[specified_cols]

    non_specified_cols <- numeric_cols[!(numeric_cols %in% specified_cols)]

    if(length(non_specified_cols) > 0){
      res[,non_specified_cols] <- unit_key[
        unit_key$Variable %in% non_specified_cols,]
    }

    # strip converted units
    # in case of a choice prefer default
    # browser()
    units_df <- data.frame(
      zero_units = sapply(res[,numeric_cols], function(x) pull_units(x, 0)),
      first_units = sapply(res[,numeric_cols], function(x) pull_units(x, 1)),
      second_units = sapply(res[,numeric_cols], function(x) pull_units(x, 2)))
    units_df$Variable <- row.names(units_df)

    units_df$use <- NA
    units_df <- merge(units_df, unit_key,
                      all.y = FALSE, all.x = TRUE, sort = FALSE)

    units_df$use <- lapply(seq_len(nrow(units_df)), function(x) {
        res <- which(units_df$units[x] ==
                     units_df[x, c("zero_units", "first_units", "second_units")]) - 1
        if(length(res) < 1){
          res <- 0
        }else{
          if(length(res) > 1){
            res <- res[1]
          }
        }
          res
        })

    res[,numeric_cols] <- sapply(seq_len(nrow(units_df)), function(x)
      pull_position(res[, numeric_cols[x]], units_df$use[x]))

    # assign units using the units package
    # res[,numeric_cols]
    quantities <- lapply(seq_len(length(numeric_cols)), function(x){
                          quantity <- res[,numeric_cols[x]]
                          quantity <- gsub(",", "", quantity)
                          quantity <- strsplit(quantity, " ")[[1]]

                          units::set_units(as.numeric(quantity[1][1]),
                                           units::as_units(quantity[2]),
                                           mode = "standard")
    })

    names(quantities) <- numeric_cols
    quantities <- as.data.frame(quantities)
    names(quantities) <- numeric_cols

    res[,numeric_cols] <- quantities
  }

  res
}
