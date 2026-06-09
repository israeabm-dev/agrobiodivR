# =============================================================================
# Projet : agrobiodivR
#
# Auteur : Israe Ait Oubrahim
# Email : israeabm@gmail.com
#
# Description :
# Cartographie des habitats et corridors ecologiques.
# =============================================================================

#' Plot connectivity map
#'
#' Produit une carte des habitats et des corridors ecologiques.
#'
#' @param habitat_sf Objet sf contenant les habitats.
#' @param corridors_sf Objet sf contenant les corridors ecologiques.
#'
#' @return Un graphique ggplot.
#'
#' @examples
#' library(sf)
#'
#' habitat_sf <- st_sf(
#'   id = 1:2,
#'   geometry = st_sfc(
#'     st_point(c(0, 0)),
#'     st_point(c(1, 1))
#'   ),
#'   crs = 4326
#' )
#'
#' corridors_sf <- st_sf(
#'   id = 1,
#'   geometry = st_sfc(
#'     st_linestring(matrix(c(0, 0, 1, 1), ncol = 2, byrow = TRUE))
#'   ),
#'   crs = 4326
#' )
#'
#' plot_connectivity_map(habitat_sf, corridors_sf)
#'
#' @export

plot_connectivity_map <- function(habitat_sf, corridors_sf){

  if(!inherits(habitat_sf, "sf")){
    stop("habitat_sf doit etre un objet sf.")
  }

  if(!inherits(corridors_sf, "sf")){
    stop("corridors_sf doit etre un objet sf.")
  }

  map <- ggplot2::ggplot() +
    ggplot2::geom_sf(
      data = habitat_sf,
      fill = "darkgreen",
      alpha = 0.7
    ) +
    ggplot2::geom_sf(
      data = corridors_sf,
      colour = "blue",
      linewidth = 1
    ) +
    ggplot2::labs(
      title = "Connectivite ecologique"
    ) +
    ggplot2::theme_minimal()

  return(map)
}

