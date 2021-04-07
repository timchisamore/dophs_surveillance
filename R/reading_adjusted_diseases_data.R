#' Reading Adjusted Diseases Data
#'
#' This function takes the path to our adjusted diseases data and reads it into R.
#'
#' @param adjusted_diseases_data_path a character indicating the pathway to the raw adjusted diseases data
#'
#' @return a tbl_df of the raw adjusted diseases data
#' @export
#'
#' @examples
#' reading_adjusted_diseases_data(here::here("data", "raw", "adjusted_diseases.csv"))
reading_adjusted_diseases_data <- function(adjusted_diseases_data_path) {
  # reading the raw data in
  raw_adjusted_diseases_data <- read_csv(file = adjusted_diseases_data_path)
  
  return(raw_adjusted_diseases_data)
}
