#!/bin/bash

### Chromosome of interest number

CHR=$@

echo "Chromosome of interest number $CHR"
### Input VCF
IN=/scratch/MHC_release_A_B/gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_maf_ex_0.05_no_indels_chr_6.vcf.gz

## Output file
OUT=/scratch/MHC_release_A_B/GEN/gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_maf_ex_0.05_no_indels_chr_6_from_vcf_file_B_relase_with_A_filtering.snptest

## Sample file
SAMPLE=/scratch/MHC_release_A_B/snptest_sample_file_case_848_control_6514_PID_all.sample

## When start ?

echo "chr_""$CHR"": Start :"
date

snptest -data $IN $SAMPLE -o $OUT -cov_all -frequentist 1 -method score -pheno PID_case -hwe > "$OUT"_console_output.txt

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
