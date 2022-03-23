#!/bin/bash
# Author: Melyssa Minto


echo "aligning sample.."
cd $WD$NAME

if [[ $to_trim = "trim" ]] && [[ $end = "SE"]]
then
STAR --genomeDir $REF \
     --runThreadN 16 \
     --outFileNamePrefix $NAME \
     --limitBAMsortRAM 20000000000 \
     --outSAMtype BAM SortedByCoordinate \
     --outSAMunmapped Within \
     --outSAMattributes Standard \
     --readFilesIn $RD'/trimmed/'$NAME'.trimmed.fastq'

elif [[ $to_trim = "trim" ]] && [[ $end = "PE"]]
then
STAR --genomeDir $REF \
     --runThreadN 16 \
     --outFileNamePrefix $NAME \
     --limitBAMsortRAM 20000000000 \
     --outSAMtype BAM SortedByCoordinate \
     --outSAMunmapped Within \
     --outSAMattributes Standard \
     --readFilesIn $RD'/trimmed/'$NAME1'.sorted.fastq' $RD'/trimmed/'$NAME2'.sorted.fastq'

elif [[ $to_trim = "no_trim" ]] && [[ $end = "SE"]]
then
STAR --genomeDir $REF \
     --runThreadN 16 \
     --outFileNamePrefix $NAME \
     --limitBAMsortRAM 20000000000 \
     --outSAMtype BAM SortedByCoordinate \
     --outSAMunmapped Within \
     --outSAMattributes Standard \
     --readFilesIn $RD'/'$NAME'.fastq'

elif [[ $to_trim = "no_trim" ]] && [[ $end = "PE"]]
wtie --trim3 30 --best --strata -l 20 -n 2 -m 4 -S -p 6 -q /media/west-lab-share/genomeData/mm10/mm10_bowtie/mm10 '../'$RD$NAME.fastq | samtools view -bS -o bowtie.bam - ) 2> bowtie_stats.txt
then
STAR --genomeDir $REF \
     --runThreadN 16 \
     --outFileNamePrefix $NAME \
     --limitBAMsortRAM 20000000000 \
     --outSAMtype BAM SortedByCoordinate \
     --outSAMunmapped Within \
     --outSAMattributes Standard \
     --readFilesIn $RD'/'$NAME1'.fastq' $RD'/'$NAME2'.fastq'
elif [[ $is_dhs == "dhs" ]]
then 

(bowtie --trim3 30 --best --strata -l 20 -n 2 -m 4 -S -p 6 -q /media/west-lab-share/genomeData/mm10/mm10_bowtie/mm10 '../'$RD$NAME.fastq | samtools view -bS -o bowtie.bam - ) 2> bowtie_stats.txt
else 
 echo "no sequence file found"
fi


