## PARAMETERS

CHR=$@

echo "Working on chromosome $CHR"
WORKING_DIR=/scratch/data_20170104-B/

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

# GEN folder for conversion CVF to GEN

if [ ! -d "GEN" ]
then
echo "Directory GEN does not exist and will be created"
mkdir -m a=rwx "GEN"
if [ $? -ne 0 ]
then
echo "Can not create folder GEN check permission"
else
echo "Created GEN"
fi
fi

# SNPTEST
if [ ! -d "SNPTEST" ]
then
echo "Directory SNPTEST does not exist and will be created"
mkdir -m a=rwx "SNPTEST"
if [ $? -ne 0 ]
then
echo "Can not create folder SNPTEST check permission"
else
echo "Created SNPTEST"
fi
fi

# Antibody Deffects
if [ ! -d "SNPTEST_AD" ]
then
echo "Directory SNPTEST does not exist and will be created"
mkdir -m a=rwx "SNPTEST_AD"
if [ $? -ne 0 ]
then
echo "Can not create folder SNPTEST_AD check permission"
else
echo "Created SNPTEST_AD"
fi
fi

# Telomers
if [ ! -d "SNPTEST_TELOMERS" ]
then
echo "Directory SNPTEST does not exist and will be created"
mkdir -m a=rwx "SNPTEST_TELOMERS"
if [ $? -ne 0 ]
then
echo "Can not create folder SNPTEST_TELOMERS check permission"
else
echo "Created SNPTEST_TELOMERS"
fi
fi

# Europeans Only
if [ ! -d "SNPTEST_EUR_ONLY" ]
then
echo "Directory SNPTEST does not exist and will be created"
mkdir -m a=rwx "SNPTEST_EUR_ONLY"
if [ $? -ne 0 ]
then
echo "Can not create folder SNPTEST_EUR_ONLY check permission"
else
echo "Created SNPTEST_EUR_ONLY"
fi
fi

# Europeans Only
if [ ! -d "SNPTEST_EUR_ONLY_NO_PC" ]
then
echo "Directory SNPTEST does not exist and will be created"
mkdir -m a=rwx "SNPTEST_EUR_ONLY_NO_PC"
if [ $? -ne 0 ]
then
echo "Can not create folder SNPTEST_EUR_ONLY_NO_PC check permission"
else
echo "Created SNPTEST_EUR_ONLY_NO_PC"
fi
fi

# Exclude monogenic
if [ ! -d "SNPTEST_EXCLUDE_MONOGENIC" ]
then
echo "Directory SNPTEST does not exist and will be created"
mkdir -m a=rwx "SNPTEST_EXCLUDE_MONOGENIC"
if [ $? -ne 0 ]
then
echo "Can not create folder SNPTEST_EXCLUDE_MONOGENIC check permission"
else
echo "Created SNPTEST_EXCLUDE_MONOGENIC"
fi
fi

# Antygody deffects Exclude monogenic
if [ ! -d "SNPTEST_AD_EXCLUDE_MONOGENIC" ]
then
echo "Directory SNPTEST does not exist and will be created"
mkdir -m a=rwx "SNPTEST_AD_EXCLUDE_MONOGENIC"
if [ $? -ne 0 ]
then
echo "Can not create folder SNPTEST_EXCLUDE_MONOGENIC check permission"
else
echo "Created SNPTEST_AD_EXCLUDE_MONOGENIC"
fi
fi

# Antygody deffects Only EUR
if [ ! -d "SNPTEST_AD_EUR_ONLY_NO_PC" ]
then
echo "Directory SNPTEST does not exist and will be created"
mkdir -m a=rwx "SNPTEST_AD_EUR_ONLY_NO_PC"
if [ $? -ne 0 ]
then
echo "Can not create folder SNPTEST_AD_EUR_ONLY_NO_PC check permission"
else
echo "Created SNPTEST_AD_EUR_ONLY_NO_PC"
fi
fi

# EUR Only exclude monogenic
if [ ! -d "SNPTEST_EUR_ONLY_NO_PC_EXCLUDE_MONOGENIC" ]
then
echo "Directory SNPTEST does not exist and will be created"
mkdir -m a=rwx "SNPTEST_EUR_ONLY_NO_PC_EXCLUDE_MONOGENIC"
if [ $? -ne 0 ]
then
echo "Can not create folder SNPTEST_EUR_ONLY_NO_PC_EXCLUDE_MONOGENIC check permission"
else
echo "Created SNPTEST_EUR_ONLY_NO_PC_EXCLUDE_MONOGENIC"
fi
fi

# Antybody deffects EUR Only exclude monogenic
if [ ! -d "SNPTEST_AD_EUR_ONLY_NO_PC_EXCLUDE_MONOGENIC" ]
then
echo "Directory SNPTEST does not exist and will be created"
mkdir -m a=rwx "SNPTEST_AD_EUR_ONLY_NO_PC_EXCLUDE_MONOGENIC"
if [ $? -ne 0 ]
then
echo "Can not create folder SNPTEST_AD_EUR_ONLY_NO_PC_EXCLUDE_MONOGENIC check permission"
else
echo "Created SNPTEST_AD_EUR_ONLY_NO_PC_EXCLUDE_MONOGENIC"
fi
fi
###

if [ -d "$WORKING_DIR"chr"$CHR" ]
then
cd "$WORKING_DIR"chr"$CHR/"
WORKING_DIR="$WORKING_DIR"chr"$CHR/"
fi
