#!/bin/bash

### Chromosome of interest number

CHR=$@

echo "Chromosome of interest number $CHR"
### Input VCF
VCF=/scratch/data/ch"$CHR"/wgs10k_20170104-A_VCF_gnomad_exclude_less_0.01_MAF_filter_0.05_chr_"$CHR"_no_indels.vcf.gz

## Output file
OUT=/scratch/data/ch"$CHR"/gen_no_indels/gs10k_20170104-A_VCF_gnomad_exclude_less_0.01_MAF_filter_0.05_chr_"$CHR"_no_indels

## When start ?

echo "chr_""$CHR"": Start :"
date

plink --vcf $VCF --recode oxford --out $OUT --noweb > $OUT".console_output"

## Status
echo "chr_""$CHR"": Done"

## When finished ?

echo "chr_""$CHR"": Finished :"
date

#* * * * *

#You then submit this script with

#sbatch --array=0-22 <sbatch_script>

# or interactive model parallely

# parallel -q --nice 19 bash F_convert_after_remove_indels_from_20170104-A_merged-vcf_no_hgmd_gnomad_0_01_MAF_less_than_0_05_all_no_sample.sh {} ::: {1..22}
