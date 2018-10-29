#!/bin/bash

### Chromosome of interest number

CHR=$@

echo "Chromosome of interest number $CHR"
### Input VCF
IN=/scratch/ru222/data_20170104-B_update/chr"$CHR"/gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_MAF_exclude_less_0.05_no_indels_chr_"$CHR".vcf.gz

## Output file
OUT=/scratch/ru222/Chr_6_recalcualtion_plink/Telomeres_length/res_pid_unrelated_ex_vasculitis_ex_monogenic/res/ch"$CHR"_telomeres_length_all

## -exclude_samples list

## --prune filters out all samples with missing phenotypes.
## EXCLUDE=/scratch/ru222/Chr_6_recalculation/cases_849_controls_unrelated_as_familyid_eq_wgsid/snptest_exclusion_list_n_2148.exclude_sample

## Eigens
EIGENVEC=/scratch/ru222/Chr_6_recalcualtion_plink/Telomeres_length/res_pid_unrelated_ex_vasculitis_ex_monogenic/eigen_file_pheno_file_continous_telomere_length_PID_ex_vasculitis_unrelated_ex_monogenic_n_825.sample

## Pheno file
PHENO=/scratch/ru222/Chr_6_recalcualtion_plink/Telomeres_length/res_pid_unrelated_ex_vasculitis_ex_monogenic/pheno_file_continous_telomere_length_PID_ex_vasculitis_unrelated_ex_monogenic_n_825.sample

## When start ?

echo "chr_""$CHR"": Start :"
date

plink --allow-no-sex --vcf $IN --linear hide-covar --covar $EIGENVEC --covar-number 1-5 --out $OUT --pheno $PHENO --pheno-name Telo_length --prune --hwe 1e-06

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
