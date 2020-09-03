#' Get Diseases
#'
#' This function takes our disease group of interest and returns the diseases corresponding to it.
#'
#' @param group a character indicating the group of diseases we are interested in
#'
#' @return a character vector of the diseases within the group of interest
#' @export
#'
#' @examples
#' get_diseases("stis")
get_diseases <- function(disease_group) {
  diseases <-
    switch(
      disease_group,
      "bbis" = c("HEPATITIS B", "HEPATITIS C", "HIV/AIDS"),
      "enterics" = c(
        "AMEBIASIS",
        "BOTULISM",
        "CAMPYLOBACTER ENTERITIS",
        "CHOLERA",
        "CREUTZFELDT-JAKOB DISEASE, ALL TYPE",
        "CRYPTOSPORIDIOSIS",
        "CYCLOSPORIASIS",
        "FOOD POISONING, ALL CAUSES",
        "GIARDIASIS",
        "HEPATITIS A",
        "LISTERIOSIS",
        "PARALYTIC SHELLFISH POISONING",
        "PARATYPHOID FEVER",
        "SALMONELLOSIS",
        "SHIGELLOSIS",
        "TRICHINOSIS",
        "TYPHOID FEVER",
        "VEROTOXIN PRODUCING E. COLI INCLUDING HUS",
        "YERSINIOSIS"
      ),
      "respiratory" = c(
        "ACUTE FLACCID PARALYSIS",
        "BLASTOMYCOSIS",
        "CARBAPENEMASE-PROD ENTEROBACTERIACEAE (CPE) INFECTION OR COLONIZATION",
        #"CORONAVIRUSES CAUSING SEVERE ACUTE RESPIRATORY ILLNESS",
        "GROUP A STREPTOCOCCAL DISEASE, INVASIVE",
        "GROUP B STREPTOCOCCAL DISEASE, NEONATAL",
        "INFLUENZA",
        "LEGIONELLOSIS",
        "LEPROSY",
        "TUBERCULOSIS"
      ),
      "stis" = c(
        "CHANCROID",
        "CHLAMYDIAL INFECTIONS",
        "GONORRHOEA (ALL TYPES)",
        "HIV/AIDS",
        "OPHTHALMIA NEONATORUM",
        "SYPHILIS, INFECTIOUS",
        "SYPHILIS, OTHER"
      ),
      "vpds" = c(
        "DIPHTHERIA",
        "CHICKENPOX (VARICELLA)",
        "HAEMOPHILUS INFLUENZAE DISEASE, ALL TYPES, INVASIVE",
        "MENINGOCOCCAL DISEASE, INVASIVE",
        "MEASLES",
        "MUMPS",
        "PERTUSSIS (WHOOPING COUGH)",
        "POLIOMYELITIS, ACUTE",
        "RUBELLA",
        "SMALLPOX",
        "STREPTOCOCCUS PNEUMONIAE, INVASIVE",
        "TETANUS"
      ),
      "vbs" = c(
        "ANTHRAX",
        "BRUCELLOSIS",
        "HANTAVIRUS PULMONARY SYNDROME",
        "HEMORRHAGIC FEVERS - EBOLA, MARBURG AND OTHER VIRAL CAUSES",
        "LYME DISEASE",
        "PLAGUE",
        "PSITTACOSIS/ORNITHOSIS",
        "Q FEVER",
        "TULAREMIA",
        "WEST NILE VIRUS ILLNESS"
      )
    )

  return(diseases)
}
