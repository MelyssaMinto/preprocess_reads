#!/bin/bash
# Author: Melyssa Minto

echo getting accepted hits...
if [[ $is_dhs = "not_dhs" ]]
then
	samtools view -F 4 -b -h -o accepted_hits.bam "$NAME"Aligned.sortedByCoord.out.bam || { echo 'ERROR: could not remove unmapped reads from .bam alignment, exiting...' ; exit 1; }
fi

echo convert bam to bed...
bedtools bamtobed -i accepted_hits.bam > sequence.bed || { echo 'ERROR: could not produce sequence.bed from .bam alignment, exiting...' ; exit 1; }

echo 'Starting filtering...'
CRMREFIX='chr'
    for (( i = 1 ; i <= 25; i++ ))
    do
    CRM=$CRMREFIX$i
    grep -w $CRM sequence.bed > "$CRM".bed  #output chromosome specific bed file
    bedtools sort -i "$CRM".bed > sorted."$CRM".bed
    done
grep -w "chrX\|chrY" sequence.bed > chrXY.bed
bedtools sort -i chrXY.bed > sorted.chrXY.bed
cat sorted.chr*bed > sorted.all.bed #combining all sorted feature files
grep -w "chrM" sequence.bed | wc -l > chrM.txt

#--Filtering--#
echo fitering duplicates
macs2 filterdup -i sorted.all.bed --keep-dup=1 -o sequence.final.bed

echo Calling ChIP peaks with MACS...
if [[ $is_dhs = "dhs" ]]
then
	macs2 callpeak -t sequence.final.bed -f BED -g mm -n ./macs_n.fdr01 -q 0.01 --nomodel --ext 147 --bdg || { echo ERROR:macs2 does not work, exiting... ; exit 1; }
	macs2 callpeak -t sequence.final.bed -f BED --broad -g mm -n ./macs_b.fdr01 -q 0.01 --nomodel --ext 147 --bdg || { echo ERROR:macs2 does not work, exiting... ; exit 1; }
else
	macs2 callpeak -t sequence.final.bed -f BED -g mm -n ./macs_n.fdr01 -q 0.01 --bdg || { echo ERROR:macs2 does not work, exiting... ; exit 1; }
	macs2 callpeak -t sequence.final.bed -f BED --broad -g mm -n ./macs_b.fdr01 -q 0.01 --bdg || { echo ERROR:macs2 does not work, exiting... ; exit 1; }
fi

