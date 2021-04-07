#' Getting Diseases Confirmed or Probable
#'
#' This function returns a character vector of the iPHIS diseases with a case
#' definition of classification in ("CONFIRMED", "PROBABLE"). This function will
#' be used in the `filtering_iphis_data` function.
#'
#' @return A `character` vector of diseases with a case definition of
#' classification in ("CONFIRMED", "PROBABLE").
#' @export
#'
#' @examples
#' `getting_diseases_confirmed_or_probable()`
getting_diseases_confirmed_or_probable <- function() {
  get_diseases_confirmed_or_probable <- c(
    "Amebiasis",
    "Blastomycosis",
    "Brucellosis",
    "Campylobacter Enteritis",
    "Chancroid",
    "Chlamydial Infections",
    "Cholera",
    "Cryptosporidiosis",
    "Cyclosporiasis",
    "Diptheria",
    "Echinococcus Multilocularis Infection",
    "Encephalitis",
    "Encephalitis/Meningitis",
    "Food Poisoning, All Causes",
    "Giardiasis",
    "Gonorrhoea (All Types)",
    "Group B Streptococcal Disease, Neonatal",
    "Haemophilus Influenzae Disease, All Types, Invasive",
    "Hemorrhagic Fever - Ebola, Marburg And Other Viral Causes",
    "Hepatitis A",
    "Hepatitis B, acute",
    "Legionellosis",
    "Leprosy",
    "Listeriosis",
    "Lyme Disease",
    "Measles",
    "Meningitis",
    "Meningococcal Disease, Invasive",
    "Mumps",
    "Ophthalmia Neonatorum",
    "Paralytic Shellfish Poisoning",
    "Paratyphoid Fever",
    "Pertussis (Whooping Cough)",
    "Plague",
    "Psittacosis/Ornithosis",
    "Q Fever",
    "Rubella",
    "Salmonellosis",
    "Shigellosis",
    "Trichinosis",
    "Tularemia",
    "Typhoid Fever",
    "Verotoxin Producing E. Coli Including HUS",
    "West Nile Virus Illness",
    "Yersiniosis"
  )
  
  return(get_diseases_confirmed_or_probable)
}
