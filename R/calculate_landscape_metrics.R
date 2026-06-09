# =============================================================================
# Projet : agrobiodivR
#
# Auteur : Israe Ait Oubrahim
# Email : israeabm@gmail.com
#
# Description :
# Calcul de metriques paysageres simples
# =============================================================================

#' Calculate landscape metrics
#'
#' Calcule quelques metriques simples du paysage.
#'
#' @param raster Raster d'occupation du sol.
#'
#' @return Tableau des metriques.
#'
#' @export

calculate_landscape_metrics <- function(raster){

  total_cells <- terra::ncell(raster)

  classes <- unique(terra::values(raster))

  n_classes <- length(classes)

  results <- data.frame(
    Total_Cells = total_cells,
    Number_Classes = n_classes
  )

  return(results)
}
