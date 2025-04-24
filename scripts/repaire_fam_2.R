
# define the path for installing R packages
.libPaths("~/R/library")

# Install renv if not already installed
#if (!requireNamespace("renv", quietly = TRUE)) {
#    install.packages("renv")
#}

# Initialize renv (only if it hasn’t been initialized already)
if (!file.exists("renv.lock")) {
    renv::init()
}

install.packages(c("dplyr", "tidyr", "stringr"))  # Add any necessary packages

library(dplyr)

# Read the original .fam file (to be repaired)
fam_old <- read.table("pruned_final_merged_caucas.fam",
                     header = FALSE, stringsAsFactors = FALSE)
colnames(fam_old) <- c("FamilyID_old", "IndividualID", "PaternalID", "MaternalID", "Sex_old", "Phenotype")

# Read the reference .ind file (source of truth)
ind <- read.table("pruned_final_merged_caucas.ind", header = FALSE, stringsAsFactors = FALSE)
colnames(ind) <- c("IndividualID", "Sex", "FamilyID")

# Convert key columns to character type for safe merging
ind$FamilyID <- as.character(ind$FamilyID)
ind$IndividualID <- as.character(ind$IndividualID)
fam_old$IndividualID <- as.character(fam_old$IndividualID)

# Merge using the IndividualID as key
merged_fam <- fam_old %>%
  left_join(ind %>% select(IndividualID, FamilyID, Sex), by = "IndividualID")

# Repair the .fam file using .ind data where available
repaired_fam <- merged_fam %>%
  mutate(
    # Use FamilyID from .ind if exists, otherwise keep original
    FamilyID = ifelse(is.na(FamilyID), FamilyID_old, FamilyID),
    # Use Sex from .ind if exists, otherwise keep original
    Sex = ifelse(is.na(Sex), Sex_old, Sex)
  ) %>%
  # Select and order columns for standard .fam format
  select(FamilyID, IndividualID, PaternalID, MaternalID, Sex, Phenotype)

# Write the repaired .fam file
write.table(repaired_fam, "repaired_pruned_final_merged_caucas.fam",
           quote = FALSE, sep = " ", row.names = FALSE, col.names = FALSE)
