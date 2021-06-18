#' Reading adjusted diseases data
#'
#' This function takes the path to our adjusted diseases data and reads it into
#' R.
#'
#' @param adjusted_diseases_path A character indicating the pathway to the raw
#' adjusted diseases data.
#'
#' @return A tbl_df of the raw adjusted diseases data.
#' @export
#'
#' @examples
#' `reading_adjusted_diseases_data(here::here("data", "raw", "adjusted-diseases_data.csv"))`
reading_adjusted_diseases_data <- function(adjusted_diseases_path) {
  # reading the raw data in
  read_csv(
    file = adjusted_diseases_path,
    col_names = TRUE,
    col_types = cols(
      disease = col_character(),
      adjusted_disease = col_character(),
      disease_group = col_character()
    )
  )
}
