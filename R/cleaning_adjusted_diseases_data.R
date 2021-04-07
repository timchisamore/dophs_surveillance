#' Cleaning Adjusted Diseases Data
#'
#' This function takes our raw adjusted diseases data and cleans it by using the
#' janitor package remove_empty and clean_name functions.
#'
#' @param raw_adjusted_diseases_data a tb_df of raw adjusted diseases data
#'
#' @return a tbl_df of clean adjusted diseases data
#' @export
#'
#' @examples
#' cleaning_adjusted_diseases_data(raw_adjusted_diseases_data)
cleaning_adjusted_diseases_data <- function(raw_adjusted_diseases_data) {
  clean_adjusted_diseases_data <- raw_adjusted_diseases_data %>%
    janitor::remove_empty(which = "cols") %>%
    janitor::clean_names()
  
  return(clean_adjusted_diseases_data)
}
