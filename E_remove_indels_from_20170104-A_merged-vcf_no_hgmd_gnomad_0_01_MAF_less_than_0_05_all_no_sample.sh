#!/bin/bash

### Chromosome of interest number

CHR=$@

echo "Chromosome of interest number $CHR"
### Input VCF
VCF=/scratch/data/ch"$CHR"/wgs10k_20170104-A_VCF_gnomad_exclude_less_0.01_MAF_filter_0.05_chr_"$CHR".vcf.gz

## Output file
OUT=/scratch/data/ch"$CHR"/wgs10k_20170104-A_VCF_gnomad_exclude_less_0.01_MAF_filter_0.05_chr_"$CHR"_no_indels.vcf.gz

## When start ?

echo "chr_""$CHR"": Start :"
date

echo "chr_""$CHR"":"

vcftools --gzvcf $VCF --remove-indels --recode --recode-INFO-all --stdout | gzip -c > $OUT

## Status
echo "chr_""$CHR"": Done"

## When finished ?

echo "chr_""$CHR"": Finished :"
date

#* * * * *

#You then submit this script with

#sbatch --array=0-22 <sbatch_script>
