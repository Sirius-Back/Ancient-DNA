#!/bin/bash

plink="/home/abydanov/ancient/tools/plink"

$plink --bfile /home/abydanov/ancient/data/db/merged_Kavkaz_admixture --indep-pairwise 200 25 0.4 --out plink --allow-no-sex

$plink --bfile /home/abydanov/ancient/data/db/merged_Kavkaz_admixture --extract plink.prune.in --make-bed --out prune --allow-no-sex
