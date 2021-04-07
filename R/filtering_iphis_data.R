#' Filtering iPHIS Data
#'
#' This function takes the clean iPHIS data and filters to ensure only cases
#' meeting defintion are included. For example, cases of chlamydial infections
#' can have a classification of confirmed or probable while cases of hepatitis C
#' must have a classification of confirmed.
#'
#' @param clean_iphis_data A `tbl_df` of clean iPHIS data.
#'
#' @return A `tbl_df` of filtered iPHIS data.
#' @export
#'
#' @examples
#' `filtering_iphis_data(clean_iphis_data)`
filtering_iphis_data <- function(clean_iphis_data) {
  # the PHO queries return observations of adjusted diseases that don't
  # necessarily meet case definition -- for example chickenpox with a
  # classification of PROBABLE
  filter_iphis_data <- clean_iphis_data %>%
    filter(
      # this filters for adjusted diseases that only meet case definition with a
      # classification of CONFIRMED
      (
        adjusted_disease %in% getting_diseases_confirmed() &
          classification == "CONFIRMED"
      ) |
        # this filters for adjusted diseases that only meet case definition with
        # a classification of CONFIRMED or PROBABLE
        (
          adjusted_disease %in% getting_diseases_confirmed_or_probable() &
            classification %in% c("CONFIRMED", "PROBABLE")
        ) |
        # this filters for adjusted diseases that only meet case definition with
        # a classification of CONFIRMED or CARRIER
        (
          adjusted_disease == getting_diseases_confirmed_or_carrier() &
            classification %in% c("CONFIRMED", "CARRIER")
        ) |
        # this filters for adjusted diseases that only meet case definition with
        # a classification of CONFIRMED or SUSPECT CASE
        (
          adjusted_disease == getting_diseases_confirmed_or_suspect() &
            classification %in% c("CONFIRMED", "SUSPECT CASE")
        ) |
        # this filters for adjusted diseases that only meet case definition with
        # a classification of CONFIRMED, PROBABLE, or SUSPECT CASE
        (
          adjusted_disease %in% getting_diseases_confirmed_probable_or_suspect() &
            classification %in% c("CONFIRMED", "PROBABLE", "SUSPECT CASE")
        )
    )
  
  return(filter_iphis_data)
}
