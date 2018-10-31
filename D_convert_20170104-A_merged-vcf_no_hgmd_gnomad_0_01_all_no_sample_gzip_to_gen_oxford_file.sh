#!/bin/bash
#SBATCH -J darwinjob
#SBATCH -A BRIDGE-PID
#SBATCH --time=36:00:00
#SBATCH --nodes=1
#SBATCH --mem=63900

CHRS=({1..22} X)
MYCHR=${CHRS[$SLURM_ARRAY_TASK_ID]}

### Chromosome of interest number

CHR=X

### Input VCF
VCF=/scratch/data/ch"$CHR"/wgs10k_20170104-A_VCF_gnomad_exclude_less_0.01_MAF_filter_0.05_chr_"$CHR".vcf.gz

## Output file
OUT=/scratch/data/ch"$CHR"/wgs10k_20170104-A_VCF_gnomad_exclude_less_0.01_MAF_filter_0.05_chr_"$CHR"_gen

## When start ?

echo "chr_""$CHR"": Start :"
date

echo "chr_""$CHR"":"

plink --vcf $VCF --recode oxford --out $OUT --noweb

## Status
echo "chr_""$CHR"": Done"

## When finished ?

echo "chr_""$CHR"": Finished :"
date

#* * * * *

#You then submit this script with

#sbatch --array=0-22 <sbatch_script>
