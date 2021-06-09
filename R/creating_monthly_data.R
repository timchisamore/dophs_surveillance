#' Creating monthly data
#'
#' This function takes the transposed aggregate case data and the
#' summarised aggregate case data and filters it for a specific year and month.
#' Any year in the future will produce an error. This data is then joined by
#' year and adjusted disease.
#'
#' @param transposed_aggregate_case_data A tbl_df of transposed aggregate case
#' data.
#' @param summarised_aggregate_case_data A tbl_df of summarised aggregate case
#' data.
#' @param report_year A numeric year for the report.
#' @param report_month A numeric month for the report.
#'
#' @return A tbl_df of monthly data.
#' @export
#'
#' @examples
#' `creating_monthly_table_data(transposed_aggregate_case_data, summarised_aggregate_case_data)`
creating_monthly_data <- function(transposed_aggregate_case_data,
                                        summarised_aggregate_case_data,
                                        report_year = lubridate::year(lubridate::today()),
                                        report_month = lubridate::month(lubridate::today())) {
  # we cannot calculate values for future years
  stopifnot("The year must not be in the future!" = report_year <= lubridate::year(lubridate::today()))

  # filtering our transposed aggregate data for the supplied year
  filter_transposed_data <- transposed_aggregate_case_data %>%
    filter(year == report_year)

  # filtering our summarised data for the supplied year and month minus one
  filter_summarised_data <- summarised_aggregate_case_data %>%
    filter(
      year == report_year,
      month == (report_month - 1)
    )

  # joining the transposed and summarised data by year and adjusted disease
  filter_transposed_data %>%
    left_join(filter_summarised_data,
      by = c("year", "adjusted_disease")
    )
}
