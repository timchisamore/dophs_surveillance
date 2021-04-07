#' Getting Diseases Confirmed
#' 
#' This function returns a character vector of the iPHIS diseases with a case
#' definition of classification = "CONFIRMED". This function will be used in the
#' `filtering_iphis_data` function.
#'
#' @return A `character` vector of diseases with a case definition of
#' classification = "CONFIRMED".
#' @export
#'
#' @examples
#' `getting_diseases_confirmed()`
getting_diseases_confirmed <- function() {
  get_diseases_confirmed <- c(
    "Acute Flaccid Paralysis",
    "Adverse Vaccine Event",
    "AIDS",
    "Carbapenemase-Prod Enterobacteriaceae (CPE)",
    "Chickenpox (Varicella)",
    "Group A Streptococcal Disease, Invasive",
    "Hantavirus Pulmonary Syndrome",
    "Hepatitis B, chronic",
    "Hepatitis C",
    "Influenza",
    "Streptococcus Pneumoniae, Invasive",
    "Syphilis, Early Congenital",
    "Syphilis, Infectious",
    "Syphilis, Latent",
    "Syphilis, Other",
    "Tetanus",
    "Tuberculosis infection, Latent"
  )
  
  return(get_diseases_confirmed)
}
