#!/bin/bash

source set_environment.sh

### Chromosome of interest number

CHR=$@

echo "Chromosome of interest number $CHR"

### Input VCF
IN=/scratch/WGS10K/data/release/20170104-B/merged-vcf/no_hgmd/chr"$CHR"_agg3_dedup_vep_hgmd_filt.bcf

echo "IN="$IN

## Output file
OUT="$WORKING_DIR"gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_chr_"$CHR".vcf.gz

echo "OUT="$OUT

## When start ?

echo "chr_""$CHR"": Start :"
date

bcftools view -f 'PASS' -e '(INFO/GNOMAD_AF<0.01)' $IN | gzip -c > $OUT

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
