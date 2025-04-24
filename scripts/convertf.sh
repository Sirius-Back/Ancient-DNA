#!/bin/bash 

#SBATCH --job-name=convertf        # Job name
#SBATCH --cpus-per-task=32         # Run on a single CPU
#SBATCH --mem=32gb                 # Job memory request
#SBATCH --time=16:00:00           # Time limit hrs:min:sec
#SBATCH --output=convertf.%j.log   # Standard output and error log
#SBATCH --partition=medium
#SBATCH --constraint=hpc

#conda deactivate 
#conda activate biotools

convertf -p keep_samples.par

#conda deactivate 
