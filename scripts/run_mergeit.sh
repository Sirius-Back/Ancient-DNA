#!/bin/bash

#SBATCH --job-name=mergeit        # Job name
#SBATCH --cpus-per-task=32         # Run on a single CPU
#SBATCH --mem=32gb                 # Job memory request
#SBATCH --time=16:00:00           # Time limit hrs:min:sec
#SBATCH --output=mergeit.%j.log   # Standard output and error log
#SBATCH --partition=medium
#SBATCH --constraint=hpc

mergeit -p merge_parfile.txt 
