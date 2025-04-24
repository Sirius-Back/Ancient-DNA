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


prefix = '/home/abydanov/ancient/Admixture/kavkaz_admixture_pruned'

#result2 = f4(prefix, pop1="Yoruba.HO", pop2="Han.HO", pop3="French.HO", pop4="French.HO", allsnps=FALSE, f4mode=TRUE)

#print(result2)

# Symmetry test for the same population
#result_symmetry <- f4(data = prefix, pop1 = "Yoruba.HO", pop2 = "Han.HO", pop3 = "French.HO", pop4 = "Papuan.HO")
#print(result_symmetry)

populations = read.table("/home/abydanov/ancient/Admixture/kavkaz_admixture_pruned.fam", 
	col.names = c("Pop", "Sample", "col1", "col2", "col3", "col4"))

print("Population table is written!")

pop2 <- populations %>% 
	select(Pop) %>%
	filter(!str_detect(Pop, "Karitiana.DG|Russia_AfontovaGora3|Mixe.DG|Eskimo_Naukan.DG|Surui.DG|USA_WA_Kennewick.SG|Russia_MA1_HG.SG|Greenland_Saqqaq.SG|Ulchi.DG|Russia_EHG|Han.DG|She.DG|Japanese.DG|Ami.DG")) %>% pull()

pop2 = c("Karitiana.DG", "Russia_AfontovaGora3", "Mixe.DG", "Eskimo_Naukan.DG", "Surui.DG", "USA_WA_Kennewick.SG", "Russia_MA1_HG.SG", "Greenland_Saqqaq.SG", "Ulchi.DG", "Russia_EHG", "Han.DG", "She.DG", "Japanese.DG", "Ami.DG")

#print(pop2)

res = data.frame(
	col1 = "Mbuti.HO",
	col2 = pop2,
	col3 = "Russia_Steppe_Maikop",
	col4 = "Russia_Steppe_Eneolithic"
)

write.table(res, file = "popfilenames.txt", quote = FALSE, sep = " ", row.names = FALSE, col.names = FALSE)

# calculate f4
#result = f4(prefix, pop1="Mbuti.HO", pop2=pop2, pop3="Russia_Steppe_Maikop", 
#	    pop4="Russia_Steppe_Eneolithic", f4mode=FALSE)

#write_xlsx(as.data.frame(result), "D_test_150125.xlsx")
