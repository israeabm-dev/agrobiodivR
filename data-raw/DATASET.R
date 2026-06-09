set.seed(123)

biodiversity_example <- data.frame(
  species = c("Bee", "Butterfly", "Bird", "Bee", "Ant"),
  abundance = c(25, 12, 8, 15, 20),
  latitude = runif(5, 32, 34),
  longitude = runif(5, -8, -6)
)

usethis::use_data(
  biodiversity_example,
  overwrite = TRUE
)
