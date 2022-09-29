
test_that("Query to the API works",{
  dataset <- dataset_query()
  expect_true(class(dataset) == "data.frame")
})

test_that("Getting the working years fails when expected",{
  # Argument is not a data.frame
  vector <- c(1,98,5)
  expect_error(years_function(dataset))
  # Wrong data.frame, as it doesn't have from and tom column names
  dataset <- data.frame(names = c("Angela","Angela","Angela"), year = c("1978", "1981","1998"))
  expect_error(years_function(dataset))

  # Wrong , as it doesn't have from
  dataset <- data.frame(names = c("Angela","Angela","Angela"),
                        from = c("1978", "1981","1998"))
  expect_error(years_function(dataset))

  # Wrong , as it doesn't have tom
  dataset <- data.frame(names = c("Angela","Angela","Angela"),
                        tom = c("1982", "1982","2001"))
  expect_error(years_function(dataset))

  # Wrong , as from column is all empty
  dataset <- data.frame(names = c("Angela","Angela","Angela"),
                        from = c("", "",""),
                        tom = c("1982", "1982","2001"))
  expect_error(years_function(dataset))
})

test_that("Getting the working works",{
  dataset <- data.frame(names = c("Angela","Angela","Angela"),
                        from = c("1978", "1981","1998"),
                        tom = c("1982", "1982","2001"))
  expect_equal(years_function(dataset),
               c(1978,1979,1980,1981,1982,1998,1999,2000,2001))
})

test_that("Getting the final dataset fails when expected",{
  # Argument is not a numeric vector
  columns_vector <- c("Name","Id","Year")
  expect_error(get_politicians_data(columns_vector))

  columns_vector <- c("1","5","8")
  expect_error(get_politicians_data(columns_vector))
})

test_that("Getting the final dataset works",{
  # It works with specific column names
  columns_vector <- c(2,8,7)
  expect_equal(names(get_politicians_data(columns_vector)),
               c("Birth_Year", "Sex", "Party", "sourceid", "tilltalsnamn", "efternamn",
                 "Years"))

  columns_vector <- c(5,6,11)
  expect_equal(names(get_politicians_data(columns_vector)),
               c("Birth_Year", "Sex", "Party", "Years"))

  # It works without arguments
  expect_equal(names(get_politicians_data()),
               c("Birth_Year", "Sex", "Party", "Years"))
})

