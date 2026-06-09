# =============================================================================
# Projet : agrobiodivR
#
# Auteur : Israe Ait Oubrahim
# Email : israeabm@gmail.com
#
# Description :
# Calcul des indices de biodiversite
# =============================================================================

#' Calculate diversity indices
#'
#' Calcule les indices de Shannon, Simpson et la richesse specifique.
#'
#' @param data Data frame contenant les especes et abondances.
#' @param species_col Nom de la colonne especes.
#' @param abundance_col Nom de la colonne abondance.
#'
#' @return Tableau contenant les indices.
#'
#' @examples
#' biodiversity_data <- data.frame(
#'   species = c("A", "B", "A", "C"),
#'   abundance = c(10, 5, 8, 3)
#' )
#'
#' calculate_diversity_indices(biodiversity_data)
#'
#' @export

calculate_diversity_indices <- function(
    data,
    species_col = "species",
    abundance_col = "abundance"
){

  abundance <- data[[abundance_col]]

  p <- abundance / sum(abundance)

  shannon <- -sum(p * log(p), na.rm = TRUE)

  simpson <- 1 - sum(p^2, na.rm = TRUE)

  richness <- length(unique(data[[species_col]]))

  results <- data.frame(
    Shannon = shannon,
    Simpson = simpson,
    Richness = richness
  )

  return(results)
}
