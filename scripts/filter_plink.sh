#!/bin/bash

#/home/abydanov/ancient/tools/plink --bfile final_merged_caucas \
#  --maf 0.01 \
#  --geno 0.7 \
#  --make-bed \
#  --out final_merged_caucas_filtered

/home/abydanov/ancient/tools/plink --geno 0.5 --allow-no-sex --indep-pairwise 200 25 0.2 \
  --bfile final_merged_caucas --out pruned --write-snplist

/home/abydanov/ancient/tools/plink --bfile final_merged_caucas --allow-no-sex --extract pruned.prune.in --make-bed --out pruned_final_merged_caucas

