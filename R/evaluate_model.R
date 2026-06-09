# =============================================================================
# Evaluation du modele
# =============================================================================

#' Evaluate model
#'
#' Calcule RMSE et R2.
#'
#' @param observed Valeurs observees.
#' @param predicted Valeurs predites.
#'
#' @return Tableau des performances.
#'
#' @export

evaluate_model <- function(
    observed,
    predicted
){

  rmse <- sqrt(
    mean((observed - predicted)^2)
  )

  r2 <- stats::cor(
    observed,
    predicted
  )^2

  data.frame(
    RMSE = rmse,
    R2 = r2
  )
}
