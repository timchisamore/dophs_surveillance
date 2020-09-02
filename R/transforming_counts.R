#' Transforming Counts
#'
#' This function takes our aggregated data representing counts by year, month, and disease and puts it
#' into a wide format for the current year, where months are spread. We also add a year to date total.
#'
#' @param counts A tbl_df of our aggregated iPHIS data representing counts by year,
#' month, and disease.
#'
#' @return A tbl_df of the most current years monthly counts in a wide format with
#' a year to date total and by disease
#' @export
#'
#' @examples
#' transform_counts(bbi_counts)
transforming_counts <- function(count) {
  current_year <- max(count$year)
  current_month <- lubridate::month(lubridate::today())

  transformed_count <- count %>%
    filter(year == current_year) %>%
    select(adjusted_disease, month, n) %>%
    pivot_wider(
      names_from = month,
      values_from = n,
      values_fill = 0
    ) %>%
    rowwise() %>%
    mutate(year_to_date = sum(c_across(cols = -adjusted_disease)))

  return(transformed_count)
}
