#!/bin/bash 

#SBATCH --job-name=admixture        # Job name
#SBATCH --cpus-per-task=32         # Run on a single CPU
#SBATCH --mem=32gb                 # Job memory request
#SBATCH --time=6-00:00:00           # Time limit hrs:min:sec
#SBATCH --output=admixture.%j.log   # Standard output and error log
#SBATCH --partition=long
#SBATCH --constraint=hpc

admixture="/home/abydanov/ancient/Admixture/dist/admixture_linux-1.3.0/admixture"
bed_file="/home/abydanov/ancient/PCA/pruned_final_merged_caucas_wo_relates.bed"

mkdir -p results_wo_relates

cd results_wo_relates
for K in {6..12}; do
    $admixture -C 100 -j8 -s time --cv $bed_file $K | tee log${K}.out
done
