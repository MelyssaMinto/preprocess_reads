#!/bin/bash
# Author: Melyssa Minto

echo sorting bam file by name 
samtools sort -n -O BAM -o sorted.bam *Aligned.sortedByCoord.out.bam

echo getting counts with htseq
htseq-count -a 30 --type=gene --format=bam --stranded=yes --idattr=gene_name sorted.bam $GTF  > gene.reads
htseq-count -a 30 --type=exon --format=bam --stranded=yes --idattr=gene_name sorted.bam $GTF  > exon.reads

