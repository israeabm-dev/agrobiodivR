# =============================================================================
# Projet : agrobiodivR
#
# Auteur : Israe Ait Oubrahim
# Email : israeabm@gmail.com
#
# Description :
# Generation d'un rapport HTML automatique.
# =============================================================================

#' Generate report
#'
#' Generate a simple HTML report summarizing the results.
#'
#' @param diversity_results Results of biodiversity indices.
#' @param landscape_results Results of landscape metrics.
#' @param connectivity_results Results of connectivity analysis.
#' @param output_file Name of the HTML file to generate.
#'
#' @return Path of the generated HTML file.
#'
#' @examples
#' diversity_results <- data.frame(Shannon = 1.5)
#' landscape_results <- data.frame(Patches = 10)
#' connectivity_results <- data.frame(Mean_Distance = 300)
#'
#' temp_report <- tempfile(fileext = ".html")
#'
#' generate_report(
#'   diversity_results,
#'   landscape_results,
#'   connectivity_results,
#'   output_file = temp_report
#' )
#'
#' @export
generate_report <- function(
    diversity_results,
    landscape_results,
    connectivity_results,
    output_file = "agrobiodiv_report.html"
) {

  report_text <- paste(
    "<html><body>",
    "<h1>Rapport agrobiodivR</h1>",

    "<h2>Indices de biodiversite</h2>",
    paste(utils::capture.output(print(diversity_results)), collapse = "<br>"),

    "<h2>Metriques paysageres</h2>",
    paste(utils::capture.output(print(landscape_results)), collapse = "<br>"),

    "<h2>Connectivite</h2>",
    paste(utils::capture.output(print(connectivity_results)), collapse = "<br>"),

    "</body></html>",
    sep = "\n"
  )

  base::writeLines(
    report_text,
    output_file
  )

  message(
    "Report generated: ",
    output_file
  )

  return(output_file)
}
