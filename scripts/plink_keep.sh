#!/bin/bash

#SBATCH --job-name=plink_keep        # Job name
#SBATCH --cpus-per-task=32         # Run on a single CPU
#SBATCH --mem=32gb                 # Job memory request
#SBATCH --time=16:00:00           # Time limit hrs:min:sec
#SBATCH --output=plink.%j.log   # Standard output and error log
#SBATCH --partition=medium
#SBATCH --constraint=hpc

/home/abydanov/ancient/tools/plink --bfile pruned_final_merged_caucas \
	--keep-allele-order \
	--allow-no-sex \
	--keep filtered_samples.txt  \
	--make-bed \
	--out pruned_final_merged_caucas_wo_relates
