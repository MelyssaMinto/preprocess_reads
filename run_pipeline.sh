#!/bin/bash
# Melyssa Minto

if [ -z "$1" ]; then
 echo usage: $0 '<name> <datadir>'
 exit
elif [ -z "$2" ]; then
 echo 'no data dir' 
 exit
fi

NAME=$1 #<name>
RD=$2 #<datadir>
WD=$3  #<working_directory>
REF=$4
GTF=$5
to_trim=$6
peak_call=$7
to_count=$8
is_dhs=$9

#export variables 
export NAME
export RD
export WD
export REF
export GTF
export to_trim
export peak_call
export to_count
export is_dhs

# run pipeline

./pipleine/01_file_setup.sh

./pipeline/02_QC.sh

if [[ $to_trim = "trim" ]]
then
./pipeline/03_trim.sh
fi

./pipeline/04_align.sh

./pipeline/05_viz.sh

if [[ $peak_call = "peak" ]]
then
./pipeline/06_peakcall.sh
fi

if [[ $to_count = "count" ]]
then 
./pipeline/07_get_counts..sh
fi

./pipeline/08_tidyoutput.sh

echo "pipeline finished"
