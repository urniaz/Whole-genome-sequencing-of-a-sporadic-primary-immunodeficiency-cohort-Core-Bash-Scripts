#!/bin/bash
#SBATCH -J PID_Convert
#SBATCH --time=12:00:00
#SBATCH --mem=32G

CHR=${1:-$SLURM_ARRAY_TASK_ID}
source ../config.env

# 1. Remove Indels and apply MAF filter
vcftools --gzvcf "${OUTPUT_DIR}/chr${CHR}_filtered.vcf.gz" \
         --maf ${EX_MAF} --remove-indels --recode --recode-INFO-all --stdout | \
         gzip -c > "${OUTPUT_DIR}/chr${CHR}_clean.vcf.gz"

# 2. Convert to Oxford Format (GEN/SAMPLE)
plink --vcf "${OUTPUT_DIR}/chr${CHR}_clean.vcf.gz" \
      --recode oxford --out "${OUTPUT_DIR}/chr${CHR}_genotypes" --noweb
