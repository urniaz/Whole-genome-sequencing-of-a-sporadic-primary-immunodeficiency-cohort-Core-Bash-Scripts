#!/bin/bash

source set_environmental_variables.sh

### Chromosome of interest number

CHR=$@

echo "Chromosome of interest number $CHR"

### Input VCF
IN="$WORKING_DIR"chr"$CHR"/GEN/gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_MAF_exclude_less_0.05_no_indels_chr_"$CHR".gen

echo "IN="$IN

## Output file
OUT="$WORKING_DIR"chr"$CHR"/SNPTEST_TELOMERS/gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_MAF_exclude_less_0.05_no_indels_SNPtest_temolers_PID_vs_Non_blood_chr_"$CHR"_newml_interactions

echo "OUT="$OUT

## Sample file
SAMPLE=/scratch/data_20170104-B_update/sample_files/snptest_sample_file_telomeres_PID_vs_Non_blood.sample

echo "SAMPLE="$SAMPLE

## When start ?

echo "chr_""$CHR"": Start :"
date

snptest -data $IN $SAMPLE -o $OUT -cov_all -frequentist 1 -method newml -pheno Telomers_continous -interaction PID_status -hwe > "$OUT"_console_output.txt

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
