#!/bin/bash -l
#SBATCH --job-name=smartpca
#SBATCH --cpus-per-task=16
#SBATCH --mem=64gb
#SBATCH --output=smartpca.%j.log
#SBATCH --partition=long

smartpca -p pca.param

