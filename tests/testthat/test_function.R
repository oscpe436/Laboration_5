context("GetKolada function")

test_that("function rejects errounous input.", {
  expect_error(GetKolada(FALSE, c("0580", "0180"))) # kpi is not character
  expect_error(GetKolada("N00090", c("0580", "0180"), "hej")) # hej is not a valid value of year
  expect_error(GetKolada("N00090", c(0580, 580))) # Incorrect municipality codes
  expect_error(GetKolada("34983414", c("0580", "0180"))) # Incorrect kpi
  })


test_that("function returns correct values.", {
  expect_is(GetKolada("N00090", c("0580", "0180")), "data.frame")
  expect_equal(ncol(GetKolada("N00090", c("0580", "0180"))), 6)
  expect_equal(GetKolada("N00090", "0580", 2010:2014), GetKolada("N00090", "0580", as.character(2010:2014)))
})


