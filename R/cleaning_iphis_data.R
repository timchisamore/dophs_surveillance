#' Cleaning iPHIS Data
#'
#' This function takes our combined iPHIS data and cleans it by using the {janitor} functions
#' remove_empty() and clean_names(). It also performs various changes to the disease field, such as specifying
#' infectious and other syphilis, and adds various temporal variables using {lubridate}, like weekday.
#' Finally, it joins our adjusted disease name file to correctly name them for reporting purposes.
#'
#' @param combined_iphis_data a tb_df of our combined iPHIS data
#' @param clean_adjusted_diseases_data a tbl_df of clean adjusted diseases data
#'
#' @return a cleaned tbl_df of our combined iPHIS data
#' @export
#'
#' @examples
#' cleaning_iphis_data(combined_iphis_data, clean_adjusted_diseases_data)
cleaning_iphis_data <- function(combined_iphis_data, clean_adjusted_diseases_data) {
  clean_iphis_data <- combined_iphis_data %>%
    janitor::remove_empty(which = "cols") %>%
    janitor::clean_names() %>%
    mutate(
      gender = as_factor(gender),
      classification = as_factor(classification),
      date = lubridate::parse_date_time(date, orders = c("%Y-%m-%d %H:%M:%S", "%Y-%m-%d")),
      date = lubridate::as_date(date),
      year = lubridate::year(date),
      quarter = lubridate::quarter(date),
      month = lubridate::month(date),
      week = lubridate::epiweek(date),
      day = lubridate::day(date),
      wday = lubridate::wday(date),
    ) %>%
    left_join(clean_adjusted_diseases_data,
      by = "disease"
    )

  return(clean_iphis_data)
}
