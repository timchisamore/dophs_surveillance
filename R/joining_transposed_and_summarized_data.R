#' Joining Transposed and Summarized Data
#'
#' This function joins our output from the transformed_counts and averaged_counts functions to create
#' a tbl_df representing the monthly counts, a year to date count, and a 5 year average and range for
#' the year to date counts for given disease.
#'
#' @param transposed_aggregate_data A tbl_df of the aggregate data transposed by month
#' @param summarized_aggregate_data A tbl_df of our 5-year average and range by disease
#'
#' @return A tbl_df of joined tranposed and summarized data that is filtered for the current year
#' and month.
#' @export
#'
#' @examples
#' joining_transposed_and_summarized_data(transposed_aggregate_data, summarized_aggregate_data)
joining_transposed_and_summarized_data <- function(transposed_aggregate_data, summarized_aggregate_data) {
  current_year <- max(transposed_aggregate_data$year)
  current_month <- lubridate::month(lubridate::today()) - 1

  joined_transposed_and_summarized_data <- transposed_aggregate_data %>%
    filter(year == current_year) %>%
    left_join(summarized_aggregate_data %>% filter(
      year == current_year,
      month == current_month
    ), by = "adjusted_disease") %>%
    select(adjusted_disease,
      year = year.x,
      month,
      `1`,
      `2`,
      `3`,
      `4`,
      `5`,
      `6`,
      `7`,
      `8`,
      `9`,
      `10`,
      `11`,
      `12`,
      year_to_date = year_to_date.x,
      `5_year_average_ytd`,
      `5_year_range_ytd`
    )

  return(joined_transposed_and_summarized_data)
}
