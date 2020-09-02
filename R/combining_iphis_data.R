#' Combining iPHIS Data
#'
#' This function takes our three iPHIS extract tbl_dfs, for the Outbreak Module (OM), STD Module, and
#' TB Module and combines them into a single tbl_df
#'
#' @param raw_om_iphis_data a tbl_df of our raw OM iPHIS data
#' @param raw_std_iphis_data a tbl_df of our raw STD Module iPHIS data
#' @param raw_tb_iphis_data a tbl_df of our raw TB Module iPHIS data
#'
#' @return a combined tbl_df of all three raw iPHIS tbl_dfs
#' @export
#'
#' @examples
#' combining_iphis_data(raw_om_iphis_data, raw_std_iphis_data, raw_tb_iphis_data)
combining_iphis_data <- function(raw_om_iphis_data, raw_std_iphis_data, raw_tb_iphis_data) {
  # binding our data into a single tbl_df
  combined_iphis_data <- bind_rows(raw_om_iphis_data, raw_std_iphis_data, raw_tb_iphis_data)

  return(combined_iphis_data)
}
