plan <- drake_plan(
  raw_om_iphis_data = reading_iphis_data(file_in(!!here::here("data", "raw", "om_surveillance_data.xlsx"))),
  raw_std_iphis_data = reading_iphis_data(file_in(!!here::here("data", "raw", "std_surveillance_data.xlsx"))),
  raw_tb_iphis_data = reading_iphis_data(file_in(!!here::here("data", "raw", "tb_surveillance_data.xlsx"))),
  combined_iphis_data = combining_iphis_data(raw_om_iphis_data, raw_std_iphis_data, raw_tb_iphis_data),
  clean_iphis_data = cleaning_iphis_data(combined_iphis_data),
  yearly_and_monthly_counts = target(
    counting_by_year_and_month(clean_iphis_data, disease_group = disease_groups),
    transform = map(
      disease_groups = c("bbis", "enterics", "respiratory", "stis", "vpds", "vbs"),
      .names = c("bbi_counts", "enteric_counts", "respiratory_counts", "sti_counts", "vpd_counts", "vb_counts")
    )
  ),
  transformed_counts = target(
    transforming_counts(yearly_and_monthly_counts),
    transform = map(
      yearly_and_monthly_counts,
      .names = c("bbi_transformed_counts", "enteric_transformed_counts", "respiratory_transformed_counts", "sti_transformed_counts", "vpd_transformed_counts", "vb_transformed_counts")
    )
  ),
  averaged_counts = target(
    averaging_counts(yearly_and_monthly_counts),
    transform = map(
      yearly_and_monthly_counts,
      .names = c("bbi_averaged_counts", "enteric_averaged_counts", "respiratory_averaged_counts", "sti_averaged_counts", "vpd_averaged_counts", "vb_averaged_counts")
    )
  ),
  joined_counts = target(
    joining_counts(transformed_counts, averaged_counts),
    transform = map(
      transformed_counts,
      averaged_counts,
      .names = c("bbi_joined_counts", "enteric_joined_counts", "respiratory_joined_counts", "sti_joined_counts", "vpd_joined_counts", "vb_joined_counts")
    )
  ),
  gt_tables = target(
    gt_tables(joined_counts),
    transform = map(
      joined_counts,
      .names = c("bbi_gt_table", "enteric_gt_table", "respiratory_gt_table", "sti_gt_table", "vpd_gt_table", "vb_gt_table")
    )
  ),
  report = rmarkdown::render(
    input = knitr_in(!!here::here("documents", "dophs_surveillance.Rmd")),
    output_file = file_out(!!here::here("documents", "dophs_surveillance.html"))
  )
)
