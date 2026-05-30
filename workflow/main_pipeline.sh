#!/bin/bash
### Master Workflow for Interactive Mode
### Usage: parallel -j 10 bash main_pipeline.sh {} ::: {1..22} X

CHR=$1
source ../config.env

echo "Running full pipeline for Chromosome ${CHR}..."

bash ../scripts/01_filter_variants.sh ${CHR}
bash ../scripts/02_remove_indels_and_convert.sh ${CHR}
bash ../scripts/03_run_snptest.sh ${CHR}

echo "Chromosome ${CHR} complete."
