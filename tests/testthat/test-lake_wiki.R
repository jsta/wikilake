context("lake_wiki")

test_that("lake_wiki works", {
  skip_on_cran()
  skip_on_travis()

  expect_false(is.na(lake_wiki("Lake Mendota")$`Max. depth`))
  expect_false(is.na(lake_wiki("Trout Lake (Wisconsin)")$`Max. depth`))
})
