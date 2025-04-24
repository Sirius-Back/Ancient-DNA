#!/bin/bash

#SBATCH --job-name=qpDstat        # Job name
#SBATCH --cpus-per-task=32         # Run on a single CPU
#SBATCH --mem=32gb                 # Job memory request
#SBATCH --time=16:00:00           # Time limit hrs:min:sec
#SBATCH --output=qpDstat.%j.log   # Standard output and error log
#SBATCH --partition=medium
#SBATCH --constraint=hpc

~/ancient/tools/AdmixTools/src/qpDstat -p PARAMETER_FILE
