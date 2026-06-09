# =============================================================================
# Projet : agrobiodivR
#
# Auteur : Israe Ait Oubrahim
# Email : israeabm@gmail.com
#
# Description :
# Analyse simple de la connectivite ecologique
# =============================================================================

#' Analyze ecological connectivity
#'
#' Analyse la connectivite entre patches d'habitats.
#'
#' @param habitat_sf Objet sf contenant les habitats.
#'
#' @return Tableau des distances entre patches.
#'
#' @examples
#' \dontrun{
#' analyze_connectivity(habitat_sf)
#' }
#'
#' @export

analyze_connectivity <- function(habitat_sf){

  if(!inherits(habitat_sf, "sf")){
    stop("L'entree doit etre un objet sf.")
  }

  distance_matrix <- sf::st_distance(habitat_sf)

  results <- data.frame(
    Mean_Distance = mean(distance_matrix),
    Min_Distance = min(distance_matrix),
    Max_Distance = max(distance_matrix)
  )

  return(results)
}
