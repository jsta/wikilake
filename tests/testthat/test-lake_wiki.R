context("lake_wiki")

test_that("lake_wiki works", {
  skip_on_cran()
  skip_on_travis()

  expect_false(is.na(
    lake_wiki("Lake Mendota")$`Max. depth`
    ))
  expect_false(is.na(lake_wiki("Trout Lake (Wisconsin)")$`Max. depth`))

  # Lake pages with multiple info boxes
  expect_false(is.na(lake_wiki("Acton Lake")$`Surface area`))

})

test_that("lake_wiki works with a vector of names", {
  skip_on_cran()
  skip_on_travis()

  expect_false(all(is.na(
    test <- lake_wiki(c("Lake Mendota","Trout Lake (Wisconsin)"))$`Max. depth`
    )))
})

test_that("simple redirects work", {
  skip_on_cran()
  skip_on_travis()

  expect_false(is.na(lake_wiki("Lake George (Michigan-Ontario)")$Name))
})

test_that("lake_wiki fails well when there is no infobox", {
  testthat::expect_s3_class(
    lake_wiki(c("Elk River Chain of Lakes Watershed", "Lake Mendota")),
    "data.frame"
  )
})


# test_that("lake_wiki fails well", {
#   skip_on_cran()
#   skip_on_travis()
#
#   expect_error(lake_wiki("Lake Bamboozle"), NA)
#
# })
