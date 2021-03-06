% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get.R
\name{lake_wiki}
\alias{lake_wiki}
\title{lake_wiki}
\usage{
lake_wiki(lake_name, map = FALSE, clean = TRUE, ...)
}
\arguments{
\item{lake_name}{character}

\item{map}{logical produce map of lake location?}

\item{clean}{logical enforce standardized units following wikilake::unit_key_()?}

\item{...}{arguments passed to maps::map}
}
\description{
lake_wiki
}
\examples{
\dontrun{
lake_wiki("Lake Peipsi")
lake_wiki("Flagstaff Lake (Maine)")
lake_wiki("Lake George (Michigan-Ontario)")
lake_wiki("Lake Michigan", map = TRUE, "usa")
lake_wiki("Lac La Belle, Michigan")
lake_wiki("Lake Antoine")
lake_wiki("Lake Baikal")
lake_wiki("Dockery Lake (Michigan)")
lake_wiki("Coldwater Lake")
lake_wiki("Bankson Lake")
lake_wiki("Fisher Lake (Michigan)")
lake_wiki("Beals Lake")
lake_wiki("Devils Lake (Michigan)")
lake_wiki("Lake Michigan")
lake_wiki("Fletcher Pond")
lake_wiki("Lake Bella Vista (Michigan)")
lake_wiki("Lake Mendota")
lake_wiki("Lake Mendota", map = TRUE, "usa")
lake_wiki("Lake Nipigon", map = TRUE, regions = "Canada")
lake_wiki("Trout Lake (Wisconsin)")

# a vector of lake names
lake_wiki(c("Lake Mendota","Trout Lake (Wisconsin)"))
lake_wiki(c("Lake Mendota","Trout Lake (Wisconsin)"), map = TRUE)

# throws warning on redirects
lake_wiki("Beals Lake")

# ignore notability box
lake_wiki("Rainbow Lake (Waterford Township, Michigan)")
}
}
