#!/bin/bash
#SBATCH -J darwinjob
#SBATCH -A BRIDGE-PID
#SBATCH --time=10:00:00
#SBATCH --nodes=1
#SBATCH --mem=63900

CHRS=({1..22} X)
MYCHR=${CHRS[$SLURM_ARRAY_TASK_ID]}

## Input VCF
## VCF=/scratch/VCF_gnomad_exclude_less_0.01/wgs10k_20170104-A_VCF_gnomad_exclude_less_0.01_chr_16_gzip.vcf.gz

## Sample file
SAMPLE=/Users/rafal/Desktop/snptest_test/snptest_sample_file.sample

## Exclude
EXCLUDE=/Users/rafal/Desktop/snptest_test/snptest_sample_file_exclude.sample

## Output directory
OUT=/Users/rafal/Desktop/snptest_test/snptest_output_chr16_range

## Bed
## BED=/scratch/VCF_gnomad_exclude_less_0.01/wgs10k_20170104-A_VCF_gnomad_exclude_less_0.01_chr_16_gzip.bed

## GEN

GEN=/Users/rafal/Desktop/snptest_test/snptest_sample_file.gen

## When start ?

echo "chr_"${MYCHR}": Start :"
date

## The following code can be used to run logistic regression via snptest
## This assumes vcf file has the genotype data in, the  *.sample file has the sample IDs, PCs and a phenotype column called IgG level.

/Applications/snptest/snptest -data $GEN $SAMPLE -o $OUT -cov_all -frequentist 1 -method score -pheno IgG_level -exclude_snps $EXCLUDE > /Users/rafal/Desktop/snptest_test/snptest_console_output_range.txt

##snptest -summary_stats_only -data $VCF $SAMPLE -o $OUT

## -data <a> <b>...: specify data files for analysis in .gen and .sample pairs. Automatic detection of .gz files.
## -o <a>: name of output file.
## -cov_all: condition on all covariates in sample files.
## -frequentist <a> <b>...: specify which Frequentist tests to fit.
## -method <a>: method used to fit model, this can be one of "threshold", "expected", "score", "ml", "newml", or "em".
## -pheno <a>: specify name of phenotype to use.


## Status
echo "SNPtest:chr_"${MYCHR}": Done"

## When finished ?

echo "chr_"${MYCHR}": Finished :"
date

#* * * * *

#You then submit this script with

#sbatch --array=0-22 <sbatch_script>
