#' Aggregating Cases by Year and Month
#'
#' This function takes our cleaned iPHIS data and a selected disease group and aggregates it by year,
#' month, and disease, and completes these so missing combinations have values of 0.
#'
#' @param clean_iphis_data A tbl_df of our cleaned iPHIS data
#' @param selected_disease_group A character indicating the disease group of interest
#'
#' @return A tbl_df containing year, disease, month, and n for each of our relevant diseases given the
#' disease group
#' @export
#'
#' @examples
#' aggregating_cases_by_year_and_month(clean_iphis_data, disease_group)
aggregating_cases_by_year_and_month <-
  function(clean_iphis_data, selected_disease_group, length = 7) {
    # calculating the counts for our diseases by year and month and filling gaps with values of 0
    aggregate_cases_by_year_and_month <- clean_iphis_data %>%
      filter(disease_group == selected_disease_group) %>%
      count(
        year,
        month,
        adjusted_disease
      ) %>%
      complete(
        year = seq(2005, lubridate::year(lubridate::today()), by = 1),
        month = 1:12,
        adjusted_disease = unique(adjusted_disease),
        fill = list(n = 0)
      )

    return(aggregate_cases_by_year_and_month)
  }
