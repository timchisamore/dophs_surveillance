#' Cleaning adjusted diseases data
#'
#' This function takes our raw adjusted diseases data and cleans it by using the
#' janitor package clean_names function.
#'
#' @param raw_adjusted_diseases_data A tb_df of raw adjusted diseases data.
#'
#' @return A tbl_df of clean adjusted diseases data.
#' @export
#'
#' @examples
#' `cleaning_adjusted_diseases_data(raw_adjusted_diseases_data)`
cleaning_adjusted_diseases_data <- function(raw_adjusted_diseases_data) {
  raw_adjusted_diseases_data %>%
    janitor::clean_names()
  
}
