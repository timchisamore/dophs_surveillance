#' Counting by Year and Month
#'
#' This function takes our cleaned iPHIS data and a disease group and aggregates it by year,
#' month, and disease, and completes these so missing combinations have values of 0.
#'
#' @param clean_iphis_data A tbl_df of our cleaned iPHIS data
#' @param disease_group A character indicating the disease group of interest
#'
#' @return A tbl_df containing year, disease, month, and n for each of our relevant diseases given the
#' disease group
#' @export
#'
#' @examples
#' counting_by_year_and_month(clean_iphis_data, disease_group)
counting_by_year_and_month <-
  function(clean_iphis_data, disease_group, length = 7) {
    # getting the diseases that correspond to the disease group given
    diseases <- get_diseases(disease_group)

    # calculating the counts for our diseases by year and month and filling gaps with values of 0
    complete_counts <- clean_iphis_data %>%
      filter(disease %in% diseases) %>%
      count(
        year,
        month,
        adjusted_disease
      ) %>%
      complete(
        year = seq(min(year), max(year), by = 1),
        month = 1:12,
        adjusted_disease = unique(adjusted_disease),
        fill = list(n = 0)
      )

    return(complete_counts)
  }
