#' Gettingdiseases confirmed, probable, or suspect
#'
#' This function returns a character vector of the iPHIS diseases with a case
#' definition of classification in ("CONFIRMED", "PROBABLE", "SUSPECT CASE").
#' This function will be used in the filtering_iphis_data function.
#'
#' @return A character vector of diseases with a case definition of
#' classification in ("CONFIRMED", "PROBABLE", "SUSPECT CASE").
#' @export
#'
#' @examples
#' `getting_diseases_confirmed_probable_or_suspect()`
getting_diseases_confirmed_probable_or_suspect <- function() {
  c(
    "Anthrax",
    "Botulism",
    "Creutzfeldt-Jakob Disease, All Type",
    "Smallpox"
  )
}
