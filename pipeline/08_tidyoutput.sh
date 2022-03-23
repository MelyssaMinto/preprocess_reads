 -ltra > files.txt

rm *clip.bdg
rm *merged.bdg
rm *sorted.bdg
rm *str*bg
rm *sortedByName.bam
rm chr*.bed
rm sorted.*

cd $RD
gzip -5 $NAME'.fastq' 

cd $TRIMMED
gzip -5 $NAME'.fastq'

