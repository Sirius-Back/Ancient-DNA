#!/bin/bash

in1=$1

convertf -p <(echo "genotypename:	${in1}.bed
snpname:	        ${in1}.bim
indivname:	      ${in1}.fam
outputformat:	    EIGENSTRAT # important, make sure output format is right 
genotypeoutname:	${in1}.geno
snpoutname:	      ${in1}.snp
indivoutname:	    ${in1}.ind")
