
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

# Load dplyr package
library(dplyr)

# Read the fam_old file
ind_old <- read.table("/projects/ancient_dna/SNP_base/v54.1.p1_1240K_public.ind", header = FALSE, stringsAsFactors = FALSE)
colnames(ind_old) <- c("IndividualID", "Sex_old", "FamilyID_old")

# Read the fam file
fam <- read.table("merged_kavkaz_fstat.ind", header = FALSE, stringsAsFactors = FALSE)
colnames(fam) <- c("IndividualID", "Sex", "FamilyID")

print("Step 1")
#print(head(ind_old))
#print(head(fam))

# Ensure columns to be combined are of the same type
fam$FamilyID <- as.character(fam$FamilyID)
ind_old$FamilyID_old <- as.character(ind_old$FamilyID_old)



# Perform a left join on the 'IndividualID' column
merged_ind <- fam %>%
  left_join(ind_old, by = "IndividualID")


# Replace FamilyID with FamilyID_old (population name) if available
repaired_ind <- merged_ind %>%
  mutate(FamilyID = coalesce(FamilyID_old, FamilyID)) %>% # Use FamilyID_old if not NA
  select(IndividualID, Sex, FamilyID) # Keep only necessary columns

# Write the output to a .fam file
write.table(repaired_ind, "repaired.fam", quote = FALSE, sep = " ", row.names = FALSE, col.names = FALSE)
