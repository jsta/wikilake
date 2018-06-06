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
    Catchment area, n, NA\n
    Basin countries, ?, NA\n
    Managing agency, ?, NA\n
    Designation, ?, NA\n
    Built, ?, NA\n
    Construction engineer, ?, NA\n
    First flooded, ?, NA\n
    Max. length, n, NA\n
    Max. width, n, NA\n
    Surface area, n, NA\n
    Average depth, n, NA\n
    Max. depth, n, NA\n
    Water volume, n, NA\n
    Residence time, n, NA\n
    Salinity, n, NA\n
    Shore length1, n, NA\n
    Surface elevation, n, NA\n
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

  known_units <- c("m", "km2", "years", "sq mi", "ha")

  # assign a default unit to numeric cols missing a unit designation
  numeric_cols <- unit_key$Variable[unit_key$format == "n"]
  numeric_cols <- names(res) %in% numeric_cols
  numeric_cols <- names(res)[numeric_cols]

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
  res[,numeric_cols] <- sapply(res[,numeric_cols],
                            function(x) stringr::str_extract(x, "^[^\\(]+"))

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

  res
}
