# =============================================================================
# Projet : agrobiodivR
#
# Auteur : Israe Ait Oubrahim
# Email : israeabm@gmail.com
#
# Description :
# Calculate the minimum distance between agricultural parcels
# and natural habitats.
# =============================================================================

#' Calculate distance to habitat
#'
#' Calculate the minimum distance between each agricultural parcel
#' and the nearest natural habitat.
#'
#' @param parcels_sf sf object containing agricultural parcels.
#' @param habitat_sf sf object containing natural habitats.
#'
#' @return A data.frame with parcel identifiers and minimum distance
#' to the nearest natural habitat.
#'
#' @examples
#' parcels_sf <- sf::st_sf(
#'   id = 1:2,
#'   geometry = sf::st_sfc(
#'     sf::st_point(c(0, 0)),
#'     sf::st_point(c(1, 1))
#'   ),
#'   crs = 4326
#' )
#'
#' habitat_sf <- sf::st_sf(
#'   id = 1,
#'   geometry = sf::st_sfc(
#'     sf::st_point(c(0.5, 0.5))
#'   ),
#'   crs = 4326
#' )
#'
#' calculate_distance_to_habitat(parcels_sf, habitat_sf)
#'
#' @export
calculate_distance_to_habitat <- function(parcels_sf, habitat_sf) {

  if (!inherits(parcels_sf, "sf")) {
    stop("parcels_sf must be an sf object.")
  }

  if (!inherits(habitat_sf, "sf")) {
    stop("habitat_sf must be an sf object.")
  }

  if (sf::st_crs(parcels_sf) != sf::st_crs(habitat_sf)) {
    stop("Both sf objects must have the same coordinate reference system.")
  }

  distance_matrix <- sf::st_distance(parcels_sf, habitat_sf)

  min_distance <- apply(distance_matrix, 1, min)

  results <- data.frame(
    parcel_id = seq_len(nrow(parcels_sf)),
    distance_to_habitat = as.numeric(min_distance)
  )

  return(results)
}

