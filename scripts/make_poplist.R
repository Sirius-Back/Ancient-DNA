
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

# install libraries
install.packages("devtools") # if "devtools" is not installed already
devtools::install_github("uqrmaie1/admixtools")
library("admixtools")
install.packages("tidyverse")
library("tidyverse")
install.packages("writexl")
library(writexl)

print("All packages are installed!")


fam_file <- read.table('/home/abydanov/ancient/f_statistics/merged_kavkaz_fstat.fam', 
        col.names = c("Pop", "Sample", "col1", "col2", "col3", "col4"))

pop1 = 'Phanagoria_Steppe'
pop2 = 'Phanagoria_Caucas'
pop3 = c('Armenia_Antiquity', 'Russia_Caucasus_Maikop_Novosvobodnaya', 'Greece_Delphi_BA_Mycenaean', 'Greece_Delphi_IA', 'Armenia_EIA', 'Italy_IA_Republic_o.SG', 'Greece_Roman', 'Greece_BA_Mycenaean', 'Italy_LA.SG', 'Russia_Caucasus_KuraAraxes', 'Iran_DinkhaTepe_BA_IA_1', 'Italy_Imperial_o1.SG', 'Koban', 'Ukraine_Scythian_lc.WGC', 'Russia_MiddleSarmatian_SouthernUrals.SG', 'Ukraine_IA_WesternScythian_Cimmerians_o2_dup.MJ32.SG', 'Russia_LateSarmatian.SG', 'Russia_EarlySarmatian.SG', 'Russia_Caucasus_EBA_Yamnaya', 'Russia_Samara_EBA_Yamnaya', 'Kazakhstan_Sarmatian_IA', 'Russia_EHG') 
pop4 = 'Yoruba.DG'

poplist <- data.frame(
	pop1 = pop1,
	pop2 = pop2,
	pop3 = pop3,
	pop4 = pop4
)

write.table(poplist, "poplist.txt", sep = "\t", row.names = FALSE, quote = FALSE)
