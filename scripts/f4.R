
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


prefix = '/home/abydanov/ancient/f_statistics/merged_kavkaz_fstat'
#my_f2_dir = '/home/abydanov/ancient/f_statistics'

#extract_f2(prefix, my_f2_dir)

#f2_blocks = f2_from_precomp(my_f2_dir)

# count all SNPs in blocks
#count_snps(f2_blocks)

####################### f3 stat

populations = read.table("/home/abydanov/ancient/f_statistics/merged_kavkaz_fstat.fam", 
	col.names = c("Pop", "Sample", "col1", "col2", "col3", "col4"))

print("Population table is written!")

pop3 <- populations %>% 
	select(Pop) %>%
	filter(!str_detect(Pop, "Phanagoria_Steppe|Yoruba.DG")) %>% pull()

# choose pops for computing the stat
pop1 = 'Kil-Dere'
pop2 = 'Phanagoria_Steppe'
#pop3 = c('Armenia_Antiquity', 'Russia_Caucasus_Maikop_Novosvobodnaya', 'Greece_Delphi_BA_Mycenaean', 'Greece_Delphi_IA', 'Armenia_EIA', 'Italy_IA_Republic_o.SG', 'Greece_Roman', 'Greece_BA_Mycenaean', 'Italy_LA.SG', 'Russia_Caucasus_KuraAraxes', 'Iran_DinkhaTepe_BA_IA_1', 'Italy_Imperial_o1.SG', 'Koban', 'Ukraine_Scythian_lc.WGC', 'Russia_MiddleSarmatian_SouthernUrals.SG', 'Ukraine_IA_WesternScythian_Cimmerians_o2_dup.MJ32.SG', 'Russia_LateSarmatian.SG', 'Russia_EarlySarmatian.SG', 'Russia_Caucasus_EBA_Yamnaya', 'Russia_Samara_EBA_Yamnaya', 'Kazakhstan_Sarmatian_IA', 'Russia_EHG') 
pop4 = 'Yoruba.DG'


######
pop1 = 'Kil-Dere'
pop2 = 'Phanagoria_Steppe'
pop3 = 'Kazakhstan_Sarmatian_IA'
######

result2 = f4(prefix, pop1, pop2, pop3, pop4, f4mode=TRUE)
#qpdstat(f2_blocks, pop1, pop2, pop3, pop4)
# two names for the same function
print(head(result2))


# compute f4 directly from geno file
#prefix = '/home/abydanov/ancient/Admixture/kavkaz_admixture_pruned'
#result <- f4(prefix, pop1, pop2, pop3, pop4, f4mode = FALSE)

#write.table(result, "f4_result.tsv")

# f4 fo Kil-Dere and Germanassa samples

#pop1 = 'Kil-Dere'
#pop2 = c('Germanassa', 'Phanagoria')
#pop3 <- populations %>%
#        select(Pop) %>%
#        filter(!str_detect(Pop, "Kil-Dere|Germanassa|Yoruba.HO")) %>% pull()


#result2 <- f4(prefix, pop1, pop2, pop3, pop4, f4mode = FALSE)
#write.table(result2, "f4_result_301224.tsv")
write_xlsx(as.data.frame(result2), "f4_result_120225.xlsx")

#result2 <- f4(prefix, pop1='Kil-Dere', pop2='Germanassa', pop3='Goths1', pop4='Yoruba.HO', f4mode = FALSE)
#print(result2)

#print("F4 is calculated for Goth1!")

#result2 <- f4(prefix, pop1='Kil-Dere', pop2='Germanassa', pop3='Goths2', pop4='Yoruba.HO', f4mode = FALSE)
#print(result2)

#print("F4 is calculated for Goth2!")
# compute f3 




