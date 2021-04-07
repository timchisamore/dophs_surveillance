#' Creating gt Table
#'
#' This funtion uses the {gt} package to create a nice table for our counts by disease
#' and month for the current year. We add a table spanner for the months.
#'
#' @param joined_data A tbl_df of joined tranposed and summarized data that is filtered for the current year
#' and month
#'
#' @return a gt table indicating the monthly counts, year-to-date count, and 5-year average and range of
#' the year-to-date counts by disease for the current year
#' @export
#'
#' @examples
#' creating_gt_table(joined_data)
creating_gt_table <- function(joined_data) {
  create_gt_table <- joined_data %>%
    gt(rowname_col = "adjusted_disease") %>%
    cols_label(
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
    cols_hide(columns = c("year", "month")) %>%
    tab_spanner(
      label = "Month",
      columns = vars(`1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `10`, `11`, `12`)
    ) %>%
    fmt_number(
      columns = vars(`5_year_average_ytd`),
      decimals = 2
    ) %>%
    opt_row_striping(row_striping = TRUE) %>%
    tab_stubhead(label = "Disease") %>%
    tab_options(table.width = "100%")

  return(create_gt_table)
}
