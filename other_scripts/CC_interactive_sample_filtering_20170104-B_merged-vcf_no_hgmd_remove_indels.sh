#!/bin/bash

### Chromosome of interest number

CHR=$@

echo "Chromosome of interest number $CHR"
### Input VCF
IN=/scratch/data_20170104-B/chr"$CHR"/gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_MAF_exclude_less_0.05_chr_"$CHR".vcf.gz

## Output file
OUT=/scratch/data_20170104-B/chr"$CHR"/gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_MAF_exclude_less_0.05_no_indels_chr_"$CHR".vcf.gz

## When start ?

echo "chr_""$CHR"": Start :"
date

vcftools --gzvcf $IN --remove-indels --recode --recode-INFO-all --stdout | gzip -c > $OUT

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
