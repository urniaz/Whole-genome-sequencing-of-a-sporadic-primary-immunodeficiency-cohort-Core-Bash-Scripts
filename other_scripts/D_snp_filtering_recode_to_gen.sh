#!/bin/bash

### Chromosome of interest number

CHR=$@

echo "Chromosome of interest number $CHR"

### Input VCF
IN=/scratch/MHC_release_A_B/gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_maf_ex_0.05_no_indels_chr_"$CHR".vcf.gz

echo "IN="$IN

## Output file
OUT=/scratch/MHC_release_A_B/GEN/gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_maf_ex_0.05_no_indels_chr_"$CHR".gen

echo "OUT="$OUT

## When start ?

echo "chr_""$CHR"": Start :"
date

plink --vcf $IN --recode oxford --out $OUT --noweb | tee $OUT".console_output"

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
