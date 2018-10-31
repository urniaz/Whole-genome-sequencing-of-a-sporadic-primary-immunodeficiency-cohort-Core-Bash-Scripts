#!/bin/bash
### This script is a SNPtets pipeline to use in interactive / screen mode
### License MIT, please note the author below:
### Author: Dr Rafal Urniaz, University of Cambridge, Cambridge, UK

### As a parameter chr{}
### Usage: parallel -q --nice 19 bash <script_name> chr{} ::: {1..22} X Y
### parallel -q --nice 19 bash E_remove_indels_from_20170104-A_merged-vcf_no_hgmd_gnomad_0_01_MAF_less_than_0_05_all_no_sample.sh {} ::: {2..15} X

## PARAMETERS

CHR=$@

# CHR=16

## Common variants parameters

EX_AF=0.01
EX_MAF=0.05

## Target directory to work in...

WORKING_DIR=/scratch/data_2/

## Original file to be filtered and work on...

VCF_INPUT_FILE=/scratch/WGS10K/data/release/20170104-B/merged-vcf/no_hgmd/chr"$CHR"_agg3_dedup_vep.vcf.gz

# /scratch/WGS10K/data/release/20170104-B/merged-vcf/no_hgmd/chr8_agg3_dedup_vep.vcf.gz

## VCF filenames, please do not add extension, only unique names

VCF_OUTPUT_A=A_filter_f_pass_exclude_gnomad_less_"$EX_AF"_maf_less_"$EX_MAF"
VCF_OUTPUT_B=B_filter_f_pass_exclude_gnomad_less_"$EX_AF"_maf_less_"$EX_MAF"
VCF_OUTPUT_C=C_filter_f_pass_exclude_gnomad_less_"$EX_AF"_maf_less_"$EX_MAF"
VCF_OUTPUT_D=D_filter_f_pass_exclude_gnomad_less_"$EX_AF"_maf_less_"$EX_MAF"

### PREP ENVIRONMENT

## Check and create directories if necessary

if [ ! -d "$WORKING_DIR" ]
  then
    echo "Directory ""$WORKING_DIR"" does not exist and will be created"
    mkdir -m a=rwx "$WORKING_DIR"
    cd "$WORKING_DIR"
  if [ $? -ne 0 ]
   then
    echo "Can not create folder $WORKING_DIR check permission"
   else
    echo "Created ""$WORKING_DIR"
    echo "I am in $WORKING_DIR"
   fi
else
 cd "$WORKING_DIR"
 echo "I am in $WORKING_DIR"
fi

## Create subfolder

if [ ! -d chr"$CHR" ]
  then
     echo "Directory chr$CHR does not exist and will be created"
     mkdir -m a=rwx chr"$CHR"
     cd chr"$CHR"
     WORKING_DIR="$WORKING_DIR"chr"$CHR/"
   if [ $? -ne 0 ]
    then
     echo "Can not create folder chr$CHR check permission"
    else
     echo "Created chr$CHR"
     echo "I am in chr$CHR"
  fi
else
 cd chr"$CHR"
 echo "I am in chr$CHR"
 WORKING_DIR="$WORKING_DIR"chr"$CHR/"
fi

###

if [ -d "$WORKING_DIR"chr"$CHR" ]
then
  cd "$WORKING_DIR"chr"$CHR/"
  WORKING_DIR="$WORKING_DIR"chr"$CHR/"
fi

### FILTERING VARIANTS ...

### ...by excluding the Allele frequency (AF), Minor allele frequency (MAF) and Overall Pass Rate(OPR) less than...
## Exclude AF less than 1% and Overall Pass Rate
## Overall Pass Rate(OPR) = PF * CR
## PF = sum of basecalls filtered from input prior to site genotyping
## CR = proportion of non-missing genotypes

#  -f, --apply-filters LIST
# Skip sites where FILTER column does not contain any of the strings listed in LIST. For example, to include only sites which have no filters set, use -f .,PASS.

# -e, --exclude

## EXCLUDE GNOMAD_AF LESS THAN 1%

OUT="$WORKING_DIR""$VCF_OUTPUT_AA"

if [ -f "$VCF_INPUT_FILE" ]
then
 if [ -f "$OUT" ]
 then
  echo "The output file $OUT for filtering variants exists so this step will be skiped and script will be continued as normally..."
 else
   echo "Filtering started on "
   date
   EXCLUDE="'(INFO/GNOMAD_AF < $EX_AF)'"
   bcftools view -f "PASS" -e "$EXCLUDE" "$VCF_INPUT_FILE" -O z -o "$OUT"
   echo "bcftools view -f PASS -e $EXCLUDE $VCF_INPUT_FILE -O z -o $OUT"
  # Write control file if command is succesfull or filed
    if [ $? -ne 0 ] ; then
      echo $? > A_succes
      # Wait a minute ...
      echo "Filtering finished succesfully"
      echo "Waitting 60 sec..."
      sleep 60
    else
      echo $? > A_failed
      echo "Filtering has failed, script was terminated on date "
      date
      exit $?
    fi
  fi
else
  echo "VCF input file ($VCF_INPUT_FILE) does not exist or read permission is not granted"
fi

## EXCLUDE MAF LESS THAN 5%

IN="$OUT"
OUT="$WORKING_DIR""$VCF_OUTPUT_A".vcf.gz

if [ -f A_succes ]
then
if [ -f "$OUT" ]
then
echo "The output file $OUT for removing indels exists so this step will be skiped and script will be continued as normally..."
else
echo "Removing indels started on "date

# Write control file if command is succesfull or failed
if [ $? -ne 0 ] ; then
echo $? > AA_succes
# Wait a minute ...
echo "Removing indels finished succesfully."
echo "Waitting 60 sec..."
sleep 60
else
echo $? > AA_failed
echo "Removing indels has failed, script was terminated on date"
date
exit $?
fi
fi
else
echo "VCF input file ($IN) does not exist or read permission is not granted"
fi


# if control file exists continue the script...

### REMOVING INDELS ...

IN="$OUT"
OUT="$WORKING_DIR""$VCF_OUTPUT_B".vcf.gz

if [ -f AA_succes ]
then
 if [ -f "$OUT" ]
 then
   echo "The output file $OUT for removing indels exists so this step will be skiped and script will be continued as normally..."
 else
  echo "Removing indels started on "date
  vcftools --gzvcf $IN --remove-indels --recode --recode-INFO-all --stdout | gzip -c > $OUT
  # Write control file if command is succesfull or failed
     if [ $? -ne 0 ] ; then
      echo $? > B_succes
      # Wait a minute ...
      echo "Removing indels finished succesfully."
      echo "Waitting 60 sec..."
      sleep 60
     else
      echo $? > B_failed
      echo "Removing indels has failed, script was terminated on date"
      date
      exit $?
     fi
  fi
else
  echo "VCF input file ($IN) does not exist or read permission is not granted"
fi

### CONVERT to GEN file for SNPtest

IN="$OUT"
OUT="$WORKING_DIR""$VCF_OUTPUT_C"

if [ -f B_succes ]
then
  if [ -f "$OUT" ]
   then
     echo "The output file $OUT for converting exists so this step will be skiped and script will be continued as normally..."
   else
    echo "Converting VCF to GEN started on "date
    plink --vcf $IN --recode oxford --out $OUT --noweb
    # Write control file if command is succesfull or failed
   if [ $? -ne 0 ] ; then
    echo $? > C_succes
    # Wait a minute ...
    echo "Converting to GEN file finished succesfully."
    echo "Waitting 60 sec..."
    sleep 60
   else
    echo $? > C_failed
    echo "Converting to GEN has failed, script was terminated on date" date
    exit $?
   fi
  fi
else
  echo "VCF input file ($IN) does not exist or read permission is not granted"
fi

### SNPtest with testing For Hardy-Weinberg Equilibrium (HWE)

IN="$OUT".gen
OUT="$WORKING_DIR""$VCF_OUTPUT_D"
SAMPLE=""

if [ -f C_succes ]
then
  if [ -f "$OUT" ]
   then
    echo "The output file $OUT for SNPtest exists so this step will be skiped and script will be continued as normally..."
   else
    echo "SNPtest started on "date
    snptest -data $IN $SAMPLE -o $OUT -cov_all -frequentist 1 -method score -pheno PID_cases -hwe | tee "$OUT_console_output.txt"
    # Write control file if command is succesfull or failed
   if [ $? -ne 0 ] ; then
    echo $? > D_succes
    # Wait a minute ...
    echo "SNPtest finished succesfully."
    echo "Waitting 60 sec..."
    sleep 60
   else
    echo $? > D_failed
    echo "SNPtest has failed, script was terminated on date" date
    exit $?
   fi
  fi
else
  echo "GEN input file ($IN) does not exist or read permission is not granted"
fi

if [ -f D_succes ]
then
 echo "Pipeline compleated on "
 date
else
 echo "Pipeline failed at some point on "
 date
fi



