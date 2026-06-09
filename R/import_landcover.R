# =============================================================================
# import_landcover.R
#
# Import land cover raster
#
# Projet : agrobiodivR
# Auteur : Israe Ait Oubrahim
# =============================================================================

#' Import land cover raster
#'
#' Import a land cover raster file.
#'
#' @param file_path Path to the raster file.
#'
#' @return A terra SpatRaster object.
#'
#' @examples
#' temp_file <- tempfile(fileext = ".tif")
#'
#' r <- terra::rast(
#'   nrows = 10,
#'   ncols = 10,
#'   xmin = 0,
#'   xmax = 10,
#'   ymin = 0,
#'   ymax = 10
#' )
#'
#' terra::values(r) <- sample(1:4, terra::ncell(r), replace = TRUE)
#' terra::writeRaster(r, temp_file, overwrite = TRUE)
#'
#' lc <- import_landcover(temp_file)
#' lc
#'
#' @export
import_landcover <- function(file_path) {

  if (!file.exists(file_path)) {
    stop("The raster file does not exist.")
  }

  extension <- tolower(tools::file_ext(file_path))

  if (!extension %in% c("tif", "tiff", "grd", "asc")) {
    stop("Unsupported raster format. Please use tif, tiff, grd or asc.")
  }

  landcover <- terra::rast(file_path)

  landcover
}

