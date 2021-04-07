#' Getting Diseases Confirmed or Carrier
#' 
#' This function returns a character vector of the iPHIS diseases with a case
#' definition of classification in ("CONFIRMED", "CARRIER"). This function will
#' be used in the `filtering_iphis_data` function.
#'
#' @return A `character` vector of diseases with a case definition of
#' classification in ("CONFIRMED", "CARRIER").
#' @export
#'
#' @examples
#' `getting_diseases_confirmed_or_carrier()`
getting_diseases_confirmed_or_carrier <- function() {
  get_diseases_confirmed_or_carrier <- "HIV"
  
  return(get_diseases_confirmed_or_carrier)
}
