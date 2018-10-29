#!/bin/bash

source set_environmental_variables.sh
source general_functions.sh

### Chromosome of interest number

CHR=$@

### Input VCF

# IN="$WORKING_DIR"chr"$CHR/"gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_chr_"$CHR".vcf.gz

# IN="$WORKING_DIR"chr"$CHR/"gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_MAF_exclude_less_0.05_no_indels_chr_"$CHR".vcf.gz

IN="$WORKING_DIR"chr"$CHR"/SNPTEST_TELOMERS/gs10k_20170104-B_VCF_gnomad_exclude_less_0.01_MAF_exclude_less_0.05_no_indels_SNPtest_temolers_all_PID_chr_"$CHR"

### Check the status

if [ -e "$IN" ]
 then

   FILE_SIZE_A=`wc -c $IN | cut -d' ' -f1`
   count_down_and_sleep 15
   FILE_SIZE_B=`wc -c $IN | cut -d' ' -f1`

  if test $FILE_SIZE_A == $FILE_SIZE_B
    then
      echo "$IN : done!"
    else
      echo "$IN : runing..."
   fi
  else
   echo "$IN : File not exists or not yet started."
fi

#* * * * *

#You then submit this script with

#sbatch --array=0-22 <sbatch_script>

# or interactive model parallely

# parallel -q --nice 19 bash  {} ::: {1..22}
