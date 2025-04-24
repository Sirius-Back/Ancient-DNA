
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



# Read id_map.txt
id_map <- read.table("id_map.txt", header = FALSE, sep = "\t", stringsAsFactors = FALSE)
colnames(id_map) <- c("MappedID", "Population", "SampleID")

# Read the .fam file
fam <- read.table("merged_kavkaz_fstat.fam", header = FALSE, stringsAsFactors = FALSE)
colnames(fam) <- c("FamilyID", "IndividualID", "PaternalID", "MaternalID", "Sex", "Phenotype")

# Extract IDs from `IndividualID` in the .fam file
fam$MappedID <- sub("^(ID\\d+):.*", "\\1", fam$IndividualID)

# Merge `fam` with `id_map`
merged_fam <- merge(fam, id_map, by = "MappedID", all.x = TRUE)

# Create a new .fam file maintaining the original format
new_fam <- data.frame(
  FamilyID = merged_fam$MappedID,       # Use MappedID as FamilyID
  IndividualID = merged_fam$MappedID,  # Use MappedID as IndividualID
  PaternalID = merged_fam$PaternalID,
  MaternalID = merged_fam$MaternalID,
  Sex = merged_fam$Sex,
  Phenotype = merged_fam$Phenotype
)

# Write the new .fam file
write.table(new_fam, "new_file.fam", quote = FALSE, sep = "\t", row.names = FALSE, col.names = FALSE)

