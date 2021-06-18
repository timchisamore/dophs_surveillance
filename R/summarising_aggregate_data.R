#' Summarising aggregate data
#'
#' This function takes the aggregated cases by disease, year, and month and
#' produces 5-year averages, 5-year minimums, and 5-year maximums for the year
#' to date values.
#'
#' @param aggregate_data_by_disease_year_and_month A tbl_df of aggregate case
#' data.
#'
#' @return A tbl_df of summarised aggregate case data.
#' @export
#'
#' @examples
#' `summarising_aggregate_data(aggregate_data_by_disease_year_and_month)`
summarising_aggregate_data <- function(aggregate_data_by_disease_year_and_month) {
  aggregate_data_by_disease_year_and_month %>%
    group_by(
      adjusted_disease,
      year
    ) %>%
    mutate(year_to_date = cumsum(n)) %>%
    ungroup(year) %>%
    group_by(month, .add = TRUE) %>%
    mutate(
      `5_year_average_ytd` = slider::slide_dbl(.x = year_to_date, .f = mean, .before = 5L, .after = -1L, .step = 1L, .complete = TRUE),
      `5_year_median_ytd` = slider::slide_dbl(.x = year_to_date, .f = median, .before = 5L, .after = -1L, .step = 1L, .complete = TRUE),
      `5_year_minimum_ytd` = slider::slide_dbl(.x = year_to_date, .f = min, .before = 5L, .after = -1L, .step = 1L, .complete = TRUE),
      `5_year_maximum_ytd` = slider::slide_dbl(.x = year_to_date, .f = max, .before = 5L, .after = -1L, .step = 1L, .complete = TRUE),
      `5_year_sd_ytd` = slider::slide_dbl(.x = year_to_date, .f = sd, .before = 5L, .after = -1L, .step = 1L, .complete = TRUE)
    ) %>%
    ungroup() %>%
    mutate(`5_year_range_ytd` = glue::glue("({`5_year_minimum_ytd`}, {`5_year_maximum_ytd`})")) %>%
    select(
      year,
      month,
      adjusted_disease,
      year_to_date,
      starts_with("5_")
    )
}
