#!/bin/bash
# Author: Melyssa Minto

echo .............$NAME..............
#set up directories
echo making sample directory...
mkdir $WD$NAME
mkdir $WD$NAME'/QC/'

# unzip file
echo checking and unzipping fastq...
cd $RD
FILE=$NAME'.fastq.gz'
cont=0

if [ -e $NAME'.fastq.gz' ]
then
 gunzip $NAME'.fastq.gz'
 echo file succesfully unzipped
 cont=1
elif [-e $NAME'.fastq']
 echo file already  unzipped
 cont=1
else
 echo file does not exist
fi

# export variables 
export cont

