# =============================================================================
# Classification des paysages agricoles
# =============================================================================

#' Cluster landscapes
#'
#' Classification des paysages par K-means.
#'
#' @param data Data frame des metriques paysageres.
#' @param k Nombre de clusters.
#'
#' @return Resultat du clustering.
#'
#' @export

cluster_landscapes <- function(data, k = 3){

  numeric_data <- data[sapply(data, is.numeric)]

  model <- stats::kmeans(
    numeric_data,
    centers = k
  )

  data$cluster <- model$cluster

  return(data)
}
