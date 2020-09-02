#' gt Tables
#'
#' This funtion uses the {gt} package to create a nice table for our counts by disease
#' and month for the current year. We add a table spanner for the months.
#'
#' @param joined_count A tbl_df returned from our joined_tables function representing
#' the monthly counts by disease and month
#'
#' @return a gt table indicating the monthly counts, year-to-date count, and 5-year average and range of
#' the year-to-date counts by disease for the current year
#' @export
#'
#' @examples
#' gt_tables(bbi_joined_counts)
gt_tables <- function(joined_count) {
  gt_table <- joined_count %>%
    select(-c(
      `5_year_min_ytd`,
      `5_year_max_ytd`
    )) %>%
    gt::gt(rowname_col = "adjusted_disease") %>%
    gt::cols_label(
      `1` = "Jan",
      `2` = "Feb",
      `3` = "Mar",
      `4` = "Apr",
      `5` = "May",
      `6` = "Jun",
      `7` = "Jul",
      `8` = "Aug",
      `9` = "Sep",
      `10` = "Oct",
      `11` = "Nov",
      `12` = "Dec",
      year_to_date = "Year to Date (YTD)",
      `5_year_average_ytd` = "5-Year Average YTD",
      `5_year_range_ytd` = "5-Year Range YTD"
    ) %>%
    gt::tab_spanner(
      label = "Month",
      columns = vars(`1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, `12`)
    ) %>%
    gt::fmt_number(
      columns = vars(`5_year_average_ytd`),
      decimals = 2
    ) %>%
    gt::opt_row_striping(row_striping = TRUE) %>%
    gt::tab_stubhead(label = "Disease") %>%
    gt::tab_options(table.width = "100%")

  return(gt_table)
}
