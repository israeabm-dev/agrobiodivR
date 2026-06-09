# =============================================================================
# Projet : agrobiodivR
#
# Auteur : Israe Ait Oubrahim
# Email : israeabm@gmail.com
#
# Description :
# Identification simple des corridors ecologiques potentiels
# =============================================================================

#' Identify ecological corridors
#'
#' Identifie des corridors ecologiques potentiels entre habitats proches.
#'
#' @param habitat_sf Objet sf contenant les patches d'habitats.
#' @param threshold_distance Distance maximale entre deux patches pour creer un corridor.
#'
#' @return Objet sf contenant les corridors potentiels.
#'
#' @examples
#' if(FALSE){
#' corridors <- identify_ecological_corridors(habitat_sf, threshold_distance = 500)
#' }
#'
#' @export

identify_ecological_corridors <- function(habitat_sf, threshold_distance = 500){

  if(!inherits(habitat_sf, "sf")){
    stop("L'entree doit etre un objet sf.")
  }

  centroids <- sf::st_centroid(habitat_sf)

  distances <- sf::st_distance(centroids)

  corridors_list <- list()
  counter <- 1

  for(i in 1:(nrow(centroids) - 1)){
    for(j in (i + 1):nrow(centroids)){

      distance_ij <- as.numeric(distances[i, j])

      if(distance_ij <= threshold_distance){

        line <- sf::st_sfc(
          sf::st_linestring(
            rbind(
              sf::st_coordinates(centroids[i, ]),
              sf::st_coordinates(centroids[j, ])
            )
          ),
          crs = sf::st_crs(habitat_sf)
        )

        corridors_list[[counter]] <- sf::st_sf(
          patch_1 = i,
          patch_2 = j,
          distance = distance_ij,
          geometry = line
        )

        counter <- counter + 1
      }
    }
  }

  if(length(corridors_list) == 0){
    message("Aucun corridor identifie avec ce seuil de distance.")
    return(NULL)
  }

  corridors <- do.call(rbind, corridors_list)

  return(corridors)
}
