#!/bin/bash
#SBATCH -J darwinjob
#SBATCH -A BRIDGE-PID
#SBATCH --time=36:00:00
#SBATCH --nodes=1
#SBATCH --mem=63900

CHRS=({1..22} X)
MYCHR=${CHRS[$SLURM_ARRAY_TASK_ID]}

### Input VCF
VCF=/scratch/WGS10K/data/release/20170104-B/merged-vcf/no_hgmd/gnomad/chr${MYCHR}_agg3_dedup_vep_gnomad.bcf

## Output file
OUTVCF=/scratch/data/ch${MYCHR}/wgs10k_20170104-A_VCF_gnomad_exclude_less_0.01_chr_${MYCHR}_gzip.vcf.gz

## When start ?

echo "chr_"${MYCHR}": Start :"
date

echo "chr_"${MYCHR}":bcftools view"

bcftools view -e '(INFO/GNOMAD_AF<0.01 || INFO/OPR<1)' \
$VCF \
| gzip -c > $OUTVCF

echo "chr_"${MYCHR}":bcftools index"

bcftools index $OUTVCF

## Status
echo "chr_"${MYCHR}": Done"

## When finished ?

echo "chr_"${MYCHR}": Finished :"
date

#* * * * *

#You then submit this script with

#sbatch --array=0-22 <sbatch_script>
