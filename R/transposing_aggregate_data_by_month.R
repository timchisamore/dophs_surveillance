#' Transposing Aggregate Data by Month
#'
#' This function takes our aggregated data representing counts of cases by year, month, and disease and puts it
#' into a wide format by month for each year and adjusted disease
#'
#' @param aggregate_data A tbl_df of our aggregated iPHIS data representing counts by year,
#' month, and disease.
#'
#' @return A tbl_df of the aggregate data transposed by month.
#' @export
#'
#' @examples
#' transform_counts(aggregate_data)
transposing_aggregate_data_by_month <- function(aggregate_data) {
  transpose_aggregate_data_by_month <- aggregate_data %>%
    select(adjusted_disease, year, month, n) %>%
    pivot_wider(
      names_from = month,
      values_from = n,
      values_fill = 0
    ) %>%
    rowwise() %>%
    mutate(year_to_date = sum(c_across(cols = -c(adjusted_disease, year))))

  return(transpose_aggregate_data_by_month)
}
