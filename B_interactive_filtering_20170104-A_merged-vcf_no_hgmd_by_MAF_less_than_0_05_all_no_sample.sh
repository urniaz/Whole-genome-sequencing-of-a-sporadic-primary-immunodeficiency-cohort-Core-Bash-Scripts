#!/bin/bash
#SBATCH -J darwinjob
#SBATCH -A BRIDGE-PID
#SBATCH --time=36:00:00
#SBATCH --nodes=1
#SBATCH --mem=63900


CHRS=({1..22} X)
MYCHR=${CHRS[$SLURM_ARRAY_TASK_ID]}

### Chromosome of interest number

CHR=15

### Input VCF
VCF=/scratch/data/ch"$CHR"/wgs10k_20170104-A_VCF_gnomad_exclude_less_0.01_chr_"$CHR"_gzip.vcf.gz

VCFOUT=/scratch/data/ch"$CHR"/wgs10k_20170104-A_VCF_gnomad_exclude_less_0.01_MAF_filter_0.05_chr_"$CHR".vcf.gz

## When start ?

echo "chr_""$CHR"": Start :"
date

vcftools --gzvcf $VCF --maf 0.05 --recode --recode-INFO-all --stdout | gzip -c > $VCFOUT

## Status
echo "chr_""$CHR"": Done"

## When finished ?

echo "chr_""$CHR"": Finished :"
date

#* * * * *

#You then submit this script with

#sbatch --array=0-22 <sbatch_script>

