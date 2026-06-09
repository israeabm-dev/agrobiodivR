# =============================================================================
# import_biodiversity_data.R
#
# Import biodiversity data
#
# Projet : agrobiodivR
# Auteur : Israe Ait Oubrahim
# =============================================================================

#' Import biodiversity data
#'
#' Import biodiversity data from a CSV or Excel file.
#'
#' Expected columns are:
#' species, abundance, latitude, longitude.
#'
#' @param file_path Path to the file to import.
#'
#' @return A data.frame containing biodiversity observations.
#'
#' @examples
#' temp_file <- tempfile(fileext = ".csv")
#'
#' example_data <- data.frame(
#'   site = c("S1", "S1", "S2", "S2"),
#'   species = c("Species_A", "Species_B", "Species_A", "Species_C"),
#'   abundance = c(10, 5, 3, 8),
#'   longitude = c(-7.1, -7.1, -7.2, -7.2),
#'   latitude = c(31.6, 31.6, 31.7, 31.7)
#' )
#'
#' utils::write.csv(example_data, temp_file, row.names = FALSE)
#'
#' result <- import_biodiversity_data(temp_file)
#' result
#'
#' @export
import_biodiversity_data <- function(file_path) {

  if (!file.exists(file_path)) {
    stop("The specified file does not exist.")
  }

  extension <- tolower(tools::file_ext(file_path))

  if (extension == "csv") {

    data <- readr::read_csv(
      file_path,
      show_col_types = FALSE
    )

  } else if (extension %in% c("xlsx", "xls")) {

    data <- readxl::read_excel(file_path)

  } else {

    stop("Unsupported file format. Please use CSV or Excel.")
  }

  data <- as.data.frame(data)

  required_columns <- c(
    "species",
    "abundance",
    "latitude",
    "longitude"
  )

  missing_columns <- setdiff(
    required_columns,
    names(data)
  )

  if (length(missing_columns) > 0) {
    stop(
      paste(
        "Missing columns:",
        paste(missing_columns, collapse = ", ")
      )
    )
  }

  data
}
