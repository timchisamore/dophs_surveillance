#' Averaging Counts
#'
#' This function takes our aggregated data representing counts by year, month, and disease and
#' calculates a 5-year average and range for the current year to date value. Note, we can supply
#' a value other than 5.
#'
#' @param counts A tbl_df of our aggregated iPHIS data representing counts by year,
#' month, and disease
#' @param length A numeric indicating how many values to include in our average and sd
#'
#' @return average_counts A tbl_df of our 5-year average and range by disease
#' @export
#'
#' @examples
#' averaging_counts(bbi_counts)
averaging_counts <- function(count, length = 5) {
  current_year <- max(count$year)
  current_month <- lubridate::month(lubridate::today())

  average_counts <- count %>%
    group_by(
      year,
      adjusted_disease
    ) %>%
    mutate(year_to_date = cumsum(n)) %>%
    ungroup() %>%
    filter(
      year %in% (current_year - 1):(current_year - length),
      month == current_month
    ) %>%
    group_by(adjusted_disease) %>%
    summarise(
      `5_year_average_ytd` = mean(year_to_date),
      `5_year_min_ytd` = min(year_to_date),
      `5_year_max_ytd` = max(year_to_date)
    ) %>%
    ungroup() %>%
    mutate(`5_year_range_ytd` = glue::glue("({`5_year_min_ytd`}, {`5_year_max_ytd`})"))

  return(average_counts)
}
