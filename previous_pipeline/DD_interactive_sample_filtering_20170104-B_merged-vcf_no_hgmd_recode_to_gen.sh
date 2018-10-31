#!/bin/bash

source set_environment.sh

### Chromosome of interest number

CHR=$@

echo "Chromosome of interest number $CHR"

### Input VCF
IN="$WORKING_DIR"gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_MAF_exclude_less_0.05_no_indels_chr_"$CHR".vcf.gz

echo "IN="$IN

## Output file
OUT="$WORKING_DIR"GEN/gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_MAF_exclude_less_0.05_no_indels_chr_"$CHR"

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
