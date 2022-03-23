#!/bin/bash
# Author: Melyssa Minto


# trim adapters
trim=/data/westlab/genomeTools/Trimmomatic-0.38/trimmomatic-0.38.jar
adapters='/data/westlab/genomeTools/Trimmomatic-0.38/adapters/'

# Trim adaptors and output to a specified folder. The name of the trimmed file is $NAME + _trimmed.fastq.gz
echo creating directory for trimmed reads
TRIMMED=$RD'/trimmed/'
mkdir $TRIMMED
cd $TRIMMED

echo trimming adaptors...
if [$end = "SE"]
then 
	java -jar $trim SE -threads 16 -phred33 $RD'/'$NAME'.fastq' ILLUMINACLIP:TruSeq3-SE:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
	mv ILLUMINACLIP\:TruSeq3-SE\:2\:30\:10 $NAME'.trimmed.fastq' #renaming file
elif [$end = "PE"]
then 
	java -jar $trim PE -threads 16 -phred33 $RD'/'$NAME1'.fastq' $RD'/'$NAME2'.fastq' $TRIMMED$NAME1'.paired.fastq' $TRIMMED$NAME1'.unpaired.fastq' $TRIMMED$NAME2'.paired.fastq' $TRIMMED$NAME2'.unpaired.fastq' ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
	cat $TRIMMED$NAME1'.paired.fastq' | paste - - - - | sort -k1,1 -t " " | tr "\t" "\n" >$TRIMMED$NAME1'.sorted.fastq'
	cat $TRIMMED$NAME2'.paired.fastq' | paste - - - - | sort -k1,1 -t " " | tr "\t" "\n" >$TRIMMED$NAME2'.sorted.fastq'
else
	echo "type of end not specified (SE|PE)"
	cont=0
fi

# exporting variables
export TRIMMED
