#' Creating monthly table
#' 
#' This function takes monthly table data and used the gt package to create a
#' table. The adjusted disease, monthly counts, and summary statistics are
#' shown.
#'
#' @param create_monthly_table_data A tbl_df of monthly table data.
#' @param group A character indicating the disease group.
#'
#' @return A gt table of monthly data.
#' @export
#'
#' @examples
#' `creating_monthly_table(create_monthly_table_data)`
creating_monthly_table <- function(create_monthly_table_data,
                                   group) {
  create_monthly_table_data %>%
    filter(disease_group == group) %>%
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
    cols_hide(columns = c("year", "month", "disease_group", "5_year_median_ytd", "5_year_minimum_ytd", "5_year_maximum_ytd", "5_year_sd_ytd")) %>%
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
  
}
