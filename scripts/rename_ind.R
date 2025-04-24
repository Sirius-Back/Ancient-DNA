
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


# Read the id_map.txt file
id_map <- read.table("id_map.txt", header = FALSE, sep = "\t", stringsAsFactors = FALSE)
colnames(id_map) <- c("MappedID", "Population", "SampleID")  # Ensure correct column names

# Read the .ind file
ind <- read.table("merged_kavkaz_fstat.ind", header = FALSE, stringsAsFactors = FALSE)
colnames(ind) <- c("V1")  # Assign a proper column name to the .ind file

# Extract the MappedID column by removing zeros between 'ID' and numbers
ind$MappedID <- sub("^(ID)0+(\\d+):.*", "\\1\\2", ind$V1)

# Ensure both data frames have correctly named columns
if (!("MappedID" %in% colnames(ind)) || !("MappedID" %in% colnames(id_map))) {
  stop("Error: 'MappedID' column is missing in one or both input files.")
}

# Merge the .ind file with id_map based on MappedID
merged_ind <- merge(ind, id_map, by = "MappedID", all.x = TRUE)

# Check for unmatched IDs and print a warning if any
missing_ids <- merged_ind[is.na(merged_ind$Population) | is.na(merged_ind$SampleID), ]
if (nrow(missing_ids) > 0) {
  cat("Warning: Some IDs in the .ind file were not found in id_map.txt:\n")
  print(missing_ids)
}

# Create the new .ind file with the standard 3-column format
final_ind <- data.frame(
  SampleID = merged_ind$SampleID,
  Sex = ifelse(grepl(" M ", merged_ind$V1), "M", "U"),  # Extract sex from the original .ind file
  Population = merged_ind$Population
)

# Write the updated .ind file
write.table(final_ind, "final_ind_file.ind", sep = "\t", quote = FALSE, row.names = FALSE, col.names = FALSE)

