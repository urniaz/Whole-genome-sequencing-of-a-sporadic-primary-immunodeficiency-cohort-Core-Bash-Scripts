#!/bin/bash

### Chromosome of interest number

CHR=$@

echo "Chromosome of interest number $CHR"
### Input VCF
IN=/scratch/data_20170104-B_update/chr"$CHR"/gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_MAF_exclude_less_0.05_no_indels_chr_"$CHR".vcf.gz

## Output file
OUT=/scratch/Chr_6_recalcualtion_plink/AntibodyDefect/res/chr_"$CHR"_res_659_control_6113_PID_and_controls_unrelated_by_falimyid_eq_wgsid_affected_ex_vasculitis_ex_monogenic_AntibodyDefect

## -exclude_samples list

## --prune filters out all samples with missing phenotypes.
## EXCLUDE=/scratch/Chr_6_recalculation/cases_849_controls_unrelated_as_familyid_eq_wgsid/snptest_exclusion_list_n_2148.exclude_sample

## Eigens
EIGENVEC=/scratch/Chr_6_recalcualtion_plink/AntibodyDefect/eigen_file_case_659_control_6113_PID_and_controls_unrelated_by_falimyid_eq_wgsid_affected_ex_vasculitis_ex_monogenic_AntibodyDefect.sample

## Pheno file
PHENO=/scratch/Chr_6_recalcualtion_plink/AntibodyDefect/pheno_file_case_659_control_6113_PID_and_controls_unrelated_by_falimyid_eq_wgsid_affected_ex_vasculitis_ex_monogenic_AntibodyDefect.sample

## When start ?

echo "chr_""$CHR"": Start :"
date

plink --allow-no-sex --vcf $IN --logistic hide-covar --covar $EIGENVEC --covar-number 1-5 --out $OUT --pheno $PHENO --pheno-name PID_case --prune --hwe 1e-06

## Status
echo "chr_""$CHR"": Done"

## When finished ?

echo "chr_""$CHR"": Finished :"
date

#* * * * *

#You then submit this script with

#sbatch --array=0-22 <sbatch_script>

# or interactive model parallely

# parallel -q --nice 19 bash  {} ::: {1..22}
