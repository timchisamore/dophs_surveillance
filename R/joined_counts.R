#' Joining Counts
#'
#' This function joins our output from the transformed_counts and averaged_counts functions to create
#' a tbl_df representing the monthly counts, a year to date count, and a 5 year average and range for
#' the  year to date counts for given diseases.
#'
#' @param transformed_count A tbl_df of the most current years monthly counts in a wide format with
#' a year to date total and by disease
#' @param averaged_count A tbl_df of our 5-year average and range by disease
#'
#' @return joined_counts A tbl_df of joined data from our transform_table and average_counts functions
#' @export
#'
#' @examples
#' joining_counts(bbi_transformed_count, bbi_averaged_count)
joining_counts <- function(transformed_count, averaged_count) {
  current_month <- lubridate::month(lubridate::today())

  joined_count <- transformed_count %>%
    left_join(averaged_count, by = "adjusted_disease")

  return(joined_count)
}
