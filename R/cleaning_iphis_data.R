#' Cleaning iPHIS data
#'
#' This function takes our combined iPHIS data and cleans it by using the
#' janitor functions remove_empty() and clean_names(). It also performs various
#' changes to the disease field, such as specifying infectious and other
#' syphilis, and adds various temporal variables using {lubridate}. Finally, it
#' joins our adjusted disease name file to correctly name them for reporting
#' purposes.
#'
#' @param combined_iphis_data A tbl_df of our combined iPHIS data.
#' @param clean_adjusted_diseases_data A tbl_df of clean adjusted diseases data.
#'
#' @return A tbl_df of cleaned iPHIS data.
#' @export
#'
#' @examples
#' `cleaning_iphis_data(combined_iphis_data, clean_adjusted_diseases_data)`
cleaning_iphis_data <- function(combined_iphis_data, clean_adjusted_diseases_data) {
  combined_iphis_data %>%
    janitor::clean_names() %>%
    mutate(
      gender = as_factor(gender),
      classification = as_factor(classification),
      date = lubridate::parse_date_time(date, orders = c("%Y-%m-%d %H:%M:%S", "%Y-%m-%d")),
      date = lubridate::as_date(date)
    ) %>%
    left_join(clean_adjusted_diseases_data,
      by = "disease"
    )
}
