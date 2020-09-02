#' Cleaning iPHIS Data
#'
#' This function takes our combined iPHIS data and cleans it by using the {janitor} functions
#' remove_empty() and clean_names(). It also performs various changes to the disease field, such as specifying
#' infectious and other syphilis, and adds various temporal variables using {lubridate}, like weekday.
#' Finally, it joins our adjusted disease name file to correctly name them for reporting purposes.
#'
#' @param combined_iphis_data a tb_df of our combined iPHIS data
#'
#' @return a cleaned tbl_df of our combined iPHIS data
#' @export
#'
#' @examples
#' cleaning_iphis_data(combined_iphis_data)
cleaning_iphis_data <- function(combined_iphis_data) {
  # using a .csv file that maps disease names found in iPHIS to our preferred names for reporting
  adjusted_disease_names <- read_csv(here::here(
    "data",
    "raw",
    "adjusted_disease_names.csv"
  ))

  clean_iphis_data <- combined_iphis_data %>%
    janitor::remove_empty(which = "cols") %>%
    janitor::clean_names() %>%
    mutate(
      date = as.Date(date),
      date = lubridate::ymd(date),
      year = lubridate::year(date),
      quarter = lubridate::quarter(date),
      month = lubridate::month(date),
      week = lubridate::epiweek(date),
      day = lubridate::day(date),
      wday = lubridate::wday(date),
      disease = case_when(
        str_detect(disease, "CARBAPENEMASE-PROD ENTEROBACTERIACEAE") ~ "CARBAPENEMASE-PROD ENTEROBACTERIACEAE (CPE) INFECTION OR COLONIZATION",
        disease %in% str_c("MENINGITIS", c("BACTERIAL", "VIRAL", "OTHER"), sep = " - ") ~ "MENINGITIS",
        disease %in% str_c(
          "ENCEPHALITIS",
          c(
            "PRIMARY VIRAL",
            "POST-INFECTIOUS",
            "VACCINE-RELATED",
            "SUBACUTE SCLEROSING PANENCAPHILITIS",
            "UNSPECIFIED"
          ),
          sep = " - "
        ) ~ "ENCEPHALITIS",
        str_detect(disease, "SYPHILIS, PRIMARY") |
          str_detect(disease, "SYPHILIS, SECONDARY") |
          disease %in%
            c(
              "SYPHILIS, EARLY LATENT",
              "SYPHILIS, INFECTIOUS NEUROSYPHILIS"
            )
        ~ "SYPHILIS, INFECTIOUS",
        disease %in% str_c(
          "SYPHILIS",
          c(
            "UNSPECIFIED",
            "OTHER TERTIARY",
            "NON-INFECTIOUS NEUROSYPHILIS",
            "NEUROSYPHILIS, UNSPECIFIED",
            "LATE LATENT"
          ),
          sep = ", "
        ) ~ "SYPHILIS, OTHER",
        str_detect(disease, "TUBERCULOSIS") ~ "TUBERCULOSIS",
        TRUE ~ disease
      ),
      age_group = str_replace_all(age_group, "< 1", "<1")
    ) %>%
    left_join(adjusted_disease_names,
      by = "disease"
    )

  return(clean_iphis_data)
}
