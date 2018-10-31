#!/bin/bash

### Chromosome of interest number

CHR=$@

echo "Chromosome of interest number $CHR"
### Input VCF
IN=/scratch/data_20170104-B/chr"$CHR"/GEN/gs10k_20170104-A_VCF_gnomad_exclude_less_0.01_MAF_filter_0.05_chr_"$CHR"_no_indels_to_gen.gen

## Output file
OUT=/scratch/data_20170104-B/chr"$CHR"/SNPTEST_EUR_ONLY_NO_PC_EXCLUDE_MONOGENIC/SNP_test_res_gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_MAF_filter_0.05_chr_"$CHR"_no_indels_EUR_only_no_PCs_exclude_monogenic

## Sample file
SAMPLE=/scratch/data_20170104-B/snptest_sample_file_European_Only_no_PCs_exclude_monogenic.sample

## When start ?

echo "chr_""$CHR"": Start :"
date

snptest -data $IN $SAMPLE -o $OUT -cov_all -frequentist 1 -method score -pheno PID_cases -hwe > "$OUT"_console_output.txt

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
