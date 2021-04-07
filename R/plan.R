plan <- drake_plan(
  raw_adjusted_diseases_data = reading_adjusted_diseases_data(file_in(!!here::here("data", "raw", "adjusted_diseases.csv"))),
  raw_iphis_data = target(reading_iphis_data(iphis_data_path),
    transform = map(
      iphis_data_path = c(
        file_in(!!here::here("data", "raw", "aids_report.xlsx")),
        file_in(!!here::here("data", "raw", "cpe_report.xlsx")),
        file_in(!!here::here("data", "raw", "hepatitis_b_chronic_report.xlsx")),
        file_in(!!here::here("data", "raw", "hiv_report.xlsx")),
        file_in(!!here::here("data", "raw", "om_report.xlsx")),
        file_in(!!here::here("data", "raw", "sti_report.xlsx")),
        file_in(!!here::here("data", "raw", "tb_report.xlsx")),
        file_in(!!here::here("data", "raw", "tuberculosis_infection_latent_report.xlsx"))
      ),
      .names = c("raw_aids_data", "raw_cpe_data", "raw_hbv_chronic_data", "raw_hiv_data", "raw_om_data", "raw_sti_data", "raw_tb_data", "raw_ltbi_data")
    )
  ),
  combined_iphis_data = target(combining_iphis_data(raw_iphis_data),
    transform = combine(raw_iphis_data)
  ),
  clean_adjusted_diseases_data = cleaning_adjusted_diseases_data(raw_adjusted_diseases_data),
  clean_iphis_data = cleaning_iphis_data(combined_iphis_data, clean_adjusted_diseases_data),
  filter_iphis_data = filtering_iphis_data(clean_iphis_data),
  aggregate_cases_by_year_and_month = target(
    aggregating_cases_by_year_and_month(filter_iphis_data, disease_group),
    transform = map(
      filter_iphis_data,
      disease_group = c("Enteric Diseases and Food-Borne Diseases", "Other", "Respiratory Diseases", "Sexually Transmitted Infections (STIs) and Blood Borne Infections (BBIs)", "Vaccine Preventable Diseases (VPDs)", "Vector-Borne and Zoonotic Diseases"),
      .names = c("aggregate_enteric_data", "aggregate_other_data", "aggregate_resp_data", "aggregate_stbbi_data", "aggregate_vpd_data", "aggregate_vector_data")
    )
  ),
  transpose_aggregate_data_by_month = target(
    transposing_aggregate_data_by_month(aggregate_cases_by_year_and_month),
    transform = map(
      aggregate_cases_by_year_and_month,
      .names = c("transpose_enteric_data", "transpose_other_data", "transpose_resp_data", "transpose_stbbi_data", "transpose_vpd_data", "transpose_vector_data")
    )
  ),
  summarize_aggregate_data_by_year = target(
    summarizing_aggregate_data_by_year(aggregate_cases_by_year_and_month),
    transform = map(
      aggregate_cases_by_year_and_month,
      .names = c("summarized_enteric_data", "summarized_other_data", "summarized_resp_data", "summarized_stbbi_data", "summarized_vpd_data", "summarized_vector_data")
    )
  ),
  joined_transposed_and_summarized_data = target(
    joining_transposed_and_summarized_data(transpose_aggregate_data_by_month, summarize_aggregate_data_by_year),
    transform = map(
      transpose_aggregate_data_by_month,
      summarize_aggregate_data_by_year,
      .names = c("joined_enteric_data", "joined_other_data", "joined_resp_data", "joined_stbbi_data", "joined_vpd_data", "joined_vector_data")
    )
  ),
  create_gt_tables = target(
    creating_gt_table(joined_transposed_and_summarized_data),
    transform = map(
      joined_transposed_and_summarized_data,
      .names = c("enteric_table", "other_table", "resp_table", "stbbi_table", "vpd_table", "vector_table")
    )
  ),
  report = rmarkdown::render(
    input = knitr_in(!!here::here("documents", "dophs_surveillance.Rmd")),
    output_file = file_out(!!here::here("documents", "dophs_surveillance.html"))
  )
)
