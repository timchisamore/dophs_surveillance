library(targets)
library(tarchetypes)
purrr::walk(.x = fs::dir_ls(path = here::here("R")), .f = source)
tar_option_set(packages = c("tidyverse", "conflicted", "gt"))
list(
  tar_file(name = adjusted_diseases_path, command = here::here("data", "raw", "adjusted-diseases_data.csv")),
  tar_file(name = aids_path, command = here::here("data", "raw", "aids_data.xlsx")),
  tar_file(name = cpe_path, command = here::here("data", "raw", "cpe_data.xlsx")),
  tar_file(name = hepatitis_b_chronic_path, command = here::here("data", "raw", "hepatitis-b-chronic_data.xlsx")),
  tar_file(name = hiv_path, command = here::here("data", "raw", "hiv_data.xlsx")),
  tar_file(name = om_path, command = here::here("data", "raw", "om_data.xlsx")),
  tar_file(name = sti_path, command = here::here("data", "raw", "sti_data.xlsx")),
  tar_file(name = tb_path, command = here::here("data", "raw", "tb_data.xlsx")),
  tar_file(name = tuberculosis_infection_latent_path, command = here::here("data", "raw", "tuberculosis-infection-latent_data.xlsx")),
  tar_target(name = raw_adjusted_diseases_data, command = reading_adjusted_diseases_data(adjusted_diseases_path)),
  tar_target(name = raw_aids_data, command = reading_iphis_data(aids_path)),
  tar_target(name = raw_cpe_data, command = reading_iphis_data(cpe_path)),
  tar_target(name = raw_hepatitis_b_chronic_data, command = reading_iphis_data(hepatitis_b_chronic_path)),
  tar_target(name = raw_hiv_data, command = reading_iphis_data(hiv_path)),
  tar_target(name = raw_om_data, command = reading_iphis_data(om_path)),
  tar_target(name = raw_sti_data, command = reading_iphis_data(sti_path)),
  tar_target(name = raw_tb_data, command = reading_iphis_data(tb_path)),
  tar_target(name = raw_tuberculosis_infection_latent_data, command = reading_iphis_data(tuberculosis_infection_latent_path)),
  tar_target(name = combined_iphis_data, command = combining_iphis_data(raw_aids_data, raw_cpe_data, raw_hepatitis_b_chronic_data, raw_hiv_data, raw_om_data, raw_sti_data, raw_tb_data, raw_tuberculosis_infection_latent_data)),
  tar_target(name = clean_adjusted_diseases_data, command = cleaning_adjusted_diseases_data(raw_adjusted_diseases_data)),
  tar_target(name = clean_iphis_data, command = cleaning_iphis_data(combined_iphis_data, clean_adjusted_diseases_data)),
  tar_target(name = filter_iphis_data, command = filtering_iphis_data(clean_iphis_data)),
  tar_target(name = aggregate_data_by_disease_year_and_month, command = aggregating_data_by_disease_year_and_month(filter_iphis_data)),
  tar_target(name = summarised_aggregate_data, command = summarising_aggregate_data(aggregate_data_by_disease_year_and_month)),
  tar_target(name = transposed_aggregate_data, command = transposing_aggregate_data(aggregate_data_by_disease_year_and_month)),
  tar_target(name = create_monthly_data, command = creating_monthly_data(transposed_aggregate_data, summarised_aggregate_data)),
  tar_target(name = create_enteric_monthly_table, command = creating_monthly_table(create_monthly_data, "Enteric Diseases and Food-Borne Diseases")),
  tar_target(name = create_resp_monthly_table, command = creating_monthly_table(create_monthly_data, "Respiratory Diseases")),
  tar_target(name = create_sti_monthly_table, command = creating_monthly_table(create_monthly_data, "Sexually Transmitted Infections (STIs) and Blood Borne Infections (BBIs)")),
  tar_target(name = create_vpd_monthly_table, command = creating_monthly_table(create_monthly_data, "Vaccine Preventable Diseases (VPDs)")),
  tar_target(name = create_vbz_monthly_table, command = creating_monthly_table(create_monthly_data, "Vector-Borne and Zoonotic Diseases")),
  tar_target(name = create_other_monthly_table, command = creating_monthly_table(create_monthly_data, "Other")),
  tar_render(name = dophs_surveillance_report, path = here::here("documents", "dophs_surveillance.Rmd"))
)
