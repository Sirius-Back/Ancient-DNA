#!/bin/bash

#SBATCH --job-name=f4        # Job name
#SBATCH --cpus-per-task=32         # Run on a single CPU
#SBATCH --mem=32gb                 # Job memory request
#SBATCH --time=6-00:00:00           # Time limit hrs:min:sec
#SBATCH --output=f4.%j.log   # Standard output and error log
#SBATCH --partition=long
#SBATCH --constraint=hpc

#Rscript f4.R
Rscript f4.R

