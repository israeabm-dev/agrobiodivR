# =============================================================================
# Projet : agrobiodivR
#
# Auteur : Israe Ait Oubrahim
# Email : israeabm@gmail.com
#
# Description :
# Generation automatique de recommandations ecologiques.
# =============================================================================

#' Generate recommendations
#'
#' Genere des recommandations a partir des indicateurs calcules.
#'
#' @param diversity_results Resultats des indices de biodiversite.
#' @param connectivity_results Resultats de connectivite.
#'
#' @return Data frame contenant les recommandations.
#'
#' @examples
#' div <- data.frame(
#'   Shannon = 1.5,
#'   Simpson = 0.7,
#'   Richness = 5
#' )
#'
#' conn <- data.frame(
#'   Mean_Distance = 600,
#'   Connectivity_Index = 0.3
#' )
#'
#' generate_recommendations(div, conn)
#'
#' @export
generate_recommendations <- function(diversity_results, connectivity_results) {

  recommendations <- c()

  shannon_value <- NA
  mean_distance <- NA

  if ("Shannon" %in% names(diversity_results)) {
    shannon_value <- diversity_results$Shannon[1]
  }

  if ("Mean_Distance" %in% names(connectivity_results)) {
    mean_distance <- connectivity_results$Mean_Distance[1]
  }

  if (!is.na(shannon_value) && shannon_value < 1.5) {
    recommendations <- c(
      recommendations,
      "Increase plant diversity."
    )
  }

  if (!is.na(mean_distance) && mean_distance > 500) {
    recommendations <- c(
      recommendations,
      "Create ecological corridors between habitats."
    )
  }

  if (length(recommendations) == 0) {
    recommendations <- c(
      "Ecological situation is satisfactory."
    )
  }

  data.frame(
    Recommendation = recommendations,
    stringsAsFactors = FALSE
  )
}
