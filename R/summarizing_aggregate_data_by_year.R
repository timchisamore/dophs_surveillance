#' Summarizing Aggregate Data by Year
#'
#' This function takes our aggregated iPHIS data representing counts by year, month, and disease and
#' calculates a 5-year average and range for the current year to date value.
#'
#' @param aggregate_data A tbl_df of our aggregated iPHIS data representing counts by year,
#' month, and disease
#'
#' @return A tbl_df of our 5-year average and range by disease
#' @export
#'
#' @examples
#' summarizing_aggregate_data_by_year(aggregate_data)
summarizing_aggregate_data_by_year <-
  function(aggregate_data) {
    summarize_aggregate_data_by_year <- aggregate_data %>%
      group_by(
        year,
        adjusted_disease
      ) %>%
      mutate(year_to_date = cumsum(n)) %>%
      ungroup() %>%
      group_by(
        adjusted_disease,
        month
      ) %>%
      mutate(
        `5_year_average_ytd` = slider::slide_dbl(
          .x = year_to_date,
          .f = mean,
          .before = 5L,
          .after = -1L,
          .step = 1L,
          .complete = TRUE
        ),
        `5_year_min_ytd` = slider::slide_dbl(
          .x = year_to_date,
          .f = min,
          .before = 5L,
          .after = -1L,
          .step = 1L,
          .complete = TRUE
        ),
        `5_year_max_ytd` = slider::slide_dbl(
          .x = year_to_date,
          .f = max,
          .before = 5L,
          .after = -1L,
          .step = 1L,
          .complete = TRUE
        )
      ) %>%
      ungroup() %>%
      mutate(`5_year_range_ytd` = glue::glue("({`5_year_min_ytd`}, {`5_year_max_ytd`})"))

    return(summarize_aggregate_data_by_year)
  }
