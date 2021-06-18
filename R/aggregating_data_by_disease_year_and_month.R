#' Aggregating data by disease, year, and month
#'
#' This function takes the clean iPHIS data and counts the number of cases by
#' disease, year, and month. Note that we are using the padr package to
#' properly cast data from dates to months and to fill in the gaps.
#'
#' @param filter_iphis_data A tbl_df of filtered iPHIS data.
#'
#' @return A tbl_df of aggregate case data by disease, year, and month.
#' @export
#'
#' @examples
#' `aggregating_data_by_disease_year_and_month(filter_iphis_data)`
aggregating_data_by_disease_year_and_month <- function(filter_iphis_data) {
  filter_iphis_data %>%
    # using a YYYY-mm-01 value to represent months and starting at 2005-01-01
    padr::thicken(
      interval = "month",
      by = "date",
      start_val = lubridate::ymd("2005-01-01")
    ) %>%
    count(
      date_month,
      disease_group,
      adjusted_disease
    ) %>%
    # using an end value of the 20xx-12-01 where 20xx represents the current
    # year
    padr::pad(
      interval = "month",
      start_val = lubridate::ymd("2005-01-01"),
      end_val = lubridate::make_date(year = lubridate::year(lubridate::today()), month = 12, day = 1),
      group = c("disease_group", "adjusted_disease"),
      by = "date_month"
    ) %>%
    # filling the padded NA values with 0s
    padr::fill_by_value(n, value = 0) %>%
    mutate(
      year = lubridate::year(date_month),
      month = lubridate::month(date_month),
      .before = 1
    )
}
