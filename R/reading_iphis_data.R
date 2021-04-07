#' Reading iPHIS Data
#'
#' This function takes the path to our iPHIS data files and reads them into R.
#'
#' @param iphis_data_path a character indicating the pathway to the raw iPHIS data
#'
#' @return a tbl_df of the raw iPHIS data
#' @export
#'
#' @examples
#' reading_iphis_data(here::here("data", "raw", "om_report.xlsx"))
reading_iphis_data <- function(iphis_data_path) {
  # readingthe raw data in
  raw_iphis_data <- readxl::read_xlsx(
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
      "numeric",
      "numeric",
      "text"
    )
  )
  
  return(raw_iphis_data)
}
