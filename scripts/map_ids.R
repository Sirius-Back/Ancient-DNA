# Read id_map.txt
id_map <- read.table("id_map.txt", header = FALSE, sep = "\t", stringsAsFactors = FALSE)
colnames(id_map) <- c("MappedID", "Population", "SampleID")

# Read the .ind file
ind <- read.table("kavkaz_admixture_pruned.ind", header = FALSE, stringsAsFactors = FALSE)
colnames(ind) <- c("IndividualID", "Sex", "Population")


# Extract IDs from `IndividualID` in the .ind file
ind$MappedID <- ind$IndividualID

ind <- ind[, c(4, 2, 3)]

# Print first few rows of the .ind file
#head(ind)

# Print first few rows of id_map
head(id_map)

# Extract the first part of the IndividualID
ind$MappedID <- sub(":.*", "", ind$MappedID)

# Pad MappedID with leading zeros
#id_map$MappedID <- sprintf("ID%06d", as.numeric(sub("ID", "", id_map$MappedID)))

# Remove all zeros between 'ID' and the first digit in MappedID
ind$MappedID <- sub("ID0+", "ID", ind$MappedID)

#head(ind)

# Rename 'Population' in id_map to avoid conflict
colnames(id_map)[colnames(id_map) == "Population"] <- "PopulationName"

# Check unique IDs in id_map and ind
#all(unique(id_map$MappedID) == unique(ind$MappedID))

# Check dimensions and structure of data frames
#dim(ind)        # Should show rows > 0
#dim(id_map)     # Should show rows > 0
#str(ind)        # Ensure columns are as expected
#str(id_map)     # Ensure columns are as expected


# Merge `ind` with `id_map`
merged_ind <- merge(ind, id_map, by = "MappedID", all.x = TRUE)

str(merged_ind)

# Create a new .ind file with mapped population and sample IDs
new_ind <- data.frame(
  IndividualID = merged_ind$SampleID,   # Use sample ID from id_map
  Sex = merged_ind$Sex,                # Retain existing sex
  Population = merged_ind$PopulationName   # Use population from id_map
)

write.table(new_ind, file = "new_kavkaz_admixture_pruned.ind", row.names = FALSE, col.names = FALSE, quote = FALSE, sep = "\t")
