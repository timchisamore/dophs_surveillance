#' Combining iPHIS Data
#'
#' This function takes the 8 tbl_dfs of raw iPHIS data and combines them into
#' a single tbl_df.
#'
#' @param raw_aids_data a tbl_df of raw AIDS data
#' @param raw_cpe_data a tbl_df of raw CPE data
#' @param raw_hbv_chronic_data a tbl_df of raw HBV chronic data
#' @param raw_hiv_data a tbl_df of raw HIV data
#' @param raw_om_data a tbl_df of raw OM data
#' @param raw_sti_data a tbl_df of raw STI data
#' @param raw_tb_data a tbl_df of raw TB data
#' @param raw_ltbi_data a tbl_df of raw LTBI data
#'
#' @return a combined tbl_df of raw iPHIS data
#' @export
#'
#' @examples
#' combining_iphis_data(raw_aids_data, raw_cpe_data, raw_hbv_chronic_data, raw_hiv_data, raw_om_data, raw_sti_data, raw_tb_data, raw_ltbi_data)
combining_iphis_data <-
  function(raw_aids_data,
           raw_cpe_data,
           raw_hbv_chronic_data,
           raw_hiv_data,
           raw_om_data,
           raw_sti_data,
           raw_tb_data,
           raw_ltbi_data) {
    # binding our data into a single tbl_df
    combined_iphis_data <-
      bind_rows(
        raw_aids_data,
        raw_cpe_data,
        raw_hbv_chronic_data,
        raw_hiv_data,
        raw_om_data,
        raw_sti_data,
        raw_tb_data,
        raw_ltbi_data,
        .id = "source"
      )

    return(combined_iphis_data)
  }
