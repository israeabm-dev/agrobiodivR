#' Train random forest model
#'
#' Entraine un modele Random Forest.
#'
#' @param data Jeu de donnees.
#' @param target Variable cible.
#'
#' @return Modele Random Forest.
#'
#' @importFrom randomForest randomForest
#'
#' @export

train_rf_model <- function(data, target){

  formula <- stats::as.formula(
    paste(target, "~ .")
  )

  model <- randomForest::randomForest(
    formula,
    data = data
  )

  return(model)
}
