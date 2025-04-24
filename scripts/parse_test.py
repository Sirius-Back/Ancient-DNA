import pandas as pd

# Read the Excel file (assuming column name is 'sample_id')
excel_samples = pd.read_excel("v62.0_1240k_public_short_2919.xlsx")['Genetic ID (suffixes: ".DG" is a high coverage shotgun genome with diploid genotype calls, ".AG" is shotgun data with each position in the genome represented by a randomly chosen sequence, ".HO" is Affymetrix Human Origins genotype data)'].tolist()

# Read the .ind file (assuming space/tab-delimited)
ind_data = pd.read_csv("/projects/ancient_dna/SNP_base/v62.0_1240k_public.ind", sep="\s+", header=None)

# Filter rows where the first column (sample ID) is in the Excel list
subset_ind = ind_data[ind_data[0].isin(excel_samples)]

# Save the subset
subset_ind.to_csv("subset.ind", sep="\t", index=False, header=False)
