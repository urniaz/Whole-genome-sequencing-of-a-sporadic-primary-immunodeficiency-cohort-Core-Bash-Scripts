#!/bin/bash

### Chromosome of interest number

CHR=$@

echo "Chromosome of interest number $CHR"

### Input VCF
IN=/scratch//WGS10K/data/release/20170104-B/merged-vcf/no_hgmd/chr"$CHR"_agg3_dedup_vep_filt.bcf

echo "IN="$IN

## Output file
OUT=/scratch/MHC_release_A_B/gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_chr_"$CHR".vcf.gz

echo "OUT="$OUT

## When start ?

echo "chr_""$CHR"": Start :"
date

bcftools view -e '(INFO/GNOMAD_AF<0.01 || INFO/OPR<1)' $IN | bgzip -c > $OUT

bcftools index $OUT

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
