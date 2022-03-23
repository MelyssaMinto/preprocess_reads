#!/bin/bash
# Author: Melyssa Minto

cd $RD 

# get fastQC
echo fastQC...
fastqc $NAME'.fastq' --outdir=$WD$NAME'/QC/'




