#!/bin/bash
#SBATCH -J PID_Filter
#SBATCH -A [YOUR_ACCOUNT]
#SBATCH --time=24:00:00
#SBATCH --mem=64G

# Use SLURM_ARRAY_TASK_ID or command line argument
CHR=${1:-$SLURM_ARRAY_TASK_ID}
source ../config.env

echo "Processing Chromosome ${CHR}..."

# Filter by gnomAD AF and OPR
bcftools view -f "PASS" -e "INFO/GNOMAD_AF < ${EX_AF} || INFO/OPR < 1" \
    "${INPUT_DIR}/chr${CHR}_merged.bcf" -O z -o "${OUTPUT_DIR}/chr${CHR}_filtered.vcf.gz"

bcftools index "${OUTPUT_DIR}/chr${CHR}_filtered.vcf.gz"
