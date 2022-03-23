#!/bin/bash
# Author: Melyssa Minto

# create bigwig

if [[ is_dhs = "dhs" ]] 
then 

samtools view -F 4 -b -h -o accepted_hits.bam bowtie_sorted.bam || { echo 'ERROR: could not remove unmapped reads from .bam alignment, exiting...' ; exit 1; }

samtools index -b accepted_hits.bam accepted_hits.bam.bai

bamCoverage -p 16 \
 -b accepted_hits.bam \
 -o $NAME'.bw' \
 --normalizeUsing BPM \
 --effectiveGenomeSize 2150570000  \
 --ignoreForNormalization chrX


else

echo indexing bam 
samtools index -b  *Aligned.sortedByCoord.out.bam $NAME'Aligned.sortedByCoord.out.bam.bai'

echo using deeptools to get normalized bigwigs
bamCoverage \
-b  *Aligned.sortedByCoord.out.bam \
-p 16  \
-o $NAME'_norm.bw' \
--normalizeUsing BPM \
--effectiveGenomeSize 2730871774 \
--ignoreForNormalization chrX 2>&1 | tee $WD$NAME'/bamcoverage.log'

fi
