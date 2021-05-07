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
  aggregate_cases_by_disease_year_and_month = aggregating_cases_by_disease_year_and_month(filter_iphis_data),
  summarised_aggregate_case_data = summarising_aggregate_case_data(aggregate_cases_by_disease_year_and_month),
  transposed_aggregate_case_data = transposing_aggregate_case_data(aggregate_cases_by_disease_year_and_month),
  create_monthly_table_data = creating_monthly_table_data(transposed_aggregate_case_data, summarised_aggregate_case_data),
  create_monthly_tables = target(creating_monthly_table(create_monthly_table_data, group),
                                 transform = map(
                                   group = c(
                                     "Enteric Diseases and Food-Borne Diseases",
                                     "Respiratory Diseases",
                                     "Sexually Transmitted Infections (STIs) and Blood Borne Infections (BBIs)",
                                     "Vaccine Preventable Diseases (VPDs)",
                                     "Vector-Borne and Zoonotic Diseases",
                                     "Other"
                                   ),
                                   .names = c("enteric_monthly_table", "resp_monthly_table", "sti_monthly_table", "vpd_monthly_table", "vbz_monthly_table", "other_monthly_table")
                                 )),
  report = rmarkdown::render(
    input = knitr_in(!!here::here("documents", "dophs_surveillance.Rmd")),
    output_file = file_out(!!here::here("documents", "dophs_surveillance.html"))
  )
)
