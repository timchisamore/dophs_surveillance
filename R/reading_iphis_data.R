#' Reading iPHIS data
#'
#' This function takes the path to our iPHIS data files and reads them into R.
#'
#' @param iphis_data_path A character indicating the pathway to the raw iPHIS
#' data.
#'
#' @return A tbl_df of the raw iPHIS data.
#' @export
#'
#' @examples
#' `reading_iphis_data(here::here("data", "raw", "om_report.xlsx"))`
reading_iphis_data <- function(iphis_data_path) {
  # reading the raw data in
  readxl::read_xlsx(
    path = iphis_data_path,
    col_names = TRUE,
    col_types = c(
      "text",
      "numeric",
      "text",
      "text",
      "text",
      "text",
      "date",
      "text",
      "text",
      "text"
    )
  )
}
