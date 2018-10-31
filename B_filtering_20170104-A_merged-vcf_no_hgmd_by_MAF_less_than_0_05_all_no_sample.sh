#!/bin/bash
#SBATCH -J darwinjob
#SBATCH -A BRIDGE-PID
#SBATCH --time=36:00:00
#SBATCH --nodes=1
#SBATCH --mem=63900


CHRS=({1..22} X)
MYCHR=${CHRS[$SLURM_ARRAY_TASK_ID]}

### Input VCF
VCF=/scratch/data/ch${MYCHR}/wgs10k_20170104-A_VCF_gnomad_exclude_less_0.01_chr_${MYCHR}_gzip.vcf.gz

VCFOUT=/scratch/data/ch${MYCHR}/wgs10k_20170104-A_VCF_gnomad_exclude_less_0.01_MAF_filter_0.05_chr_${MYCHR}.vcf.gz

## When start ?

echo "chr_"${MYCHR}": Start :"
date

vcftools --gzvcf $VCF --maf 0.05 --recode --recode-INFO-all --stdout | gzip -c > $VCFOUT

## Status
echo "chr_"${MYCHR}": Done"

## When finished ?

echo "chr_"${MYCHR}": Finished :"
date

#* * * * *

#You then submit this script with

#sbatch --array=0-22 <sbatch_script>
