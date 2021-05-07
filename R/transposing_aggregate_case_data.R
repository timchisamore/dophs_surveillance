#' Transposing aggregate case data
#'
#' This function takes the aggregate case data and transposes it so that the
#' months are columns.
#'
#' @param aggregate_cases_by_disease_year_and_month A tbl_df of aggregate cases
#' by disease, year, and month.
#'
#' @return A tbl_df of transposed aggregate case data.
#' @export
#'
#' @examples
#' `transposing_aggregate_case_data(aggregate_cases_by_disease_year_and_month)`
transposing_aggregate_case_data <- function(aggregate_cases_by_disease_year_and_month) {
  aggregate_cases_by_disease_year_and_month %>%
    select(-date_month) %>%
    pivot_wider(
      names_from = month,
      values_from = n
    )
}
