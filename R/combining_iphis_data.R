#' Combining iPHIS data
#'
#' This function takes the 8 tbl_dfs of raw iPHIS data and combines them into
#' a single tbl_df.
#'
#' @param raw_aids_data A tbl_df of raw AIDS data.
#' @param raw_cpe_data A tbl_df of raw CPE data.
#' @param raw_hepatitis_b_chronic_data A tbl_df of raw HBV chronic data.
#' @param raw_hiv_data A tbl_df of raw HIV data.
#' @param raw_om_data A tbl_df of raw OM data.
#' @param raw_sti_data A tbl_df of raw STI data.
#' @param raw_tb_data A tbl_df of raw TB data.
#' @param raw_tuberculosis_infection_latent_data A tbl_df of raw LTBI data.
#'
#' @return A combined tbl_df of raw iPHIS data.
#' @export
#'
#' @examples
#' `combining_iphis_data(raw_aids_data, raw_cpe_data, raw_hepatitis_b_chronic_data, raw_hiv_data, raw_om_data, raw_sti_data, raw_tb_data, raw_tuberculosis_infection_latent_data)`
combining_iphis_data <-
  function(raw_aids_data,
           raw_cpe_data,
           raw_hepatitis_b_chronic_data,
           raw_hiv_data,
           raw_om_data,
           raw_sti_data,
           raw_tb_data,
           raw_tuberculosis_infection_latent_data) {
    # binding our data into a single tbl_df
    bind_rows(
      raw_aids_data,
      raw_cpe_data,
      raw_hepatitis_b_chronic_data,
      raw_hiv_data,
      raw_om_data,
      raw_sti_data,
      raw_tb_data,
      raw_tuberculosis_infection_latent_data,
      .id = "source"
    )
  }
