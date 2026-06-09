# =============================================================================
# Projet : agrobiodivR
#
# Auteur : Israe Ait Oubrahim
# Email : israeabm@gmail.com
#
# Description :
# Cartographie simple des indices de biodiversite.
# =============================================================================

#' Plot biodiversity map
#'
#' Produit une carte simple des indices de biodiversite a partir d'un objet sf.
#'
#' @param biodiversity_sf Objet sf contenant les donnees de biodiversite.
#' @param index_col Nom de la colonne contenant l'indice a cartographier.
#'
#' @return Un graphique ggplot.
#'
#' @examples
#' \dontrun{
#' plot_biodiversity_map(biodiversity_sf, index_col = "Shannon")
#' }
#'
#' @export

plot_biodiversity_map <- function(biodiversity_sf, index_col = "Shannon"){

  if(!inherits(biodiversity_sf, "sf")){
    stop("biodiversity_sf doit etre un objet sf.")
  }

  if(!index_col %in% names(biodiversity_sf)){
    stop("La colonne choisie n'existe pas dans biodiversity_sf.")
  }

  map <- ggplot2::ggplot(biodiversity_sf) +
    ggplot2::geom_sf(
      ggplot2::aes_string(fill = index_col)
    ) +
    ggplot2::labs(
      title = "Carte des indices de biodiversite",
      fill = index_col
    ) +
    ggplot2::theme_minimal()

  return(map)
}
