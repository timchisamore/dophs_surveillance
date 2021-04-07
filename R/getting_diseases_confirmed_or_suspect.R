#' Getting Diseases Confirmed or Suspect
#' 
#' This function returns a character vector of the iPHIS diseases with a case
#' definition of classification in ("CONFIRMED", "SUSPECT CASE"). This function will
#' be used in the `filtering_iphis_data` function.
#'
#' @return A `character` vector of diseases with a case definition of
#' classification in ("CONFIRMED", "SUSPECT CASE").
#' @export
#'
#' @examples
#' `getting_diseases_confirmed_or_suspect()`
getting_diseases_confirmed_or_suspect <- function() {
  get_diseases_confirmed_or_suspect <- "Tuberculosis"
  
  return(get_diseases_confirmed_or_suspect)
}
