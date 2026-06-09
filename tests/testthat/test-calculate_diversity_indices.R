test_that("calculate_diversity_indices returns correct output", {

  test_data <- data.frame(
    species = c("A", "B", "C", "A"),
    abundance = c(10, 5, 3, 7)
  )

  result <- calculate_diversity_indices(test_data)

  expect_true(is.data.frame(result))
  expect_true("Shannon" %in% names(result))
  expect_true("Simpson" %in% names(result))
  expect_true("Richness" %in% names(result))
  expect_equal(result$Richness, 3)
})
