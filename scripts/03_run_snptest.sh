#!/bin/bash
#SBATCH -J PID_SNPtest
#SBATCH --time=10:00:00
#SBATCH --mem=64G

CHR=${1:-$SLURM_ARRAY_TASK_ID}
source ../config.env

# Association Testing
${SNPTEST_BIN} \
    -data "${OUTPUT_DIR}/chr${CHR}_genotypes.gen" "${SAMPLE_FILE}" \
    -o "${OUTPUT_DIR}/snptest_results_chr${CHR}.txt" \
    -cov_all -frequentist 1 -method score -pheno IgG_level \
    -exclude_snps "${EXCLUDE_LIST}" -hwe
