#!/bin/sh
for i in *.fa ; do

mkdir $i.folder
cp $i ./$i.folder/.
cd $i.folder


seqtk rename $i chr_> $i.2
prodigal -i $i.2 -a $i.faa -o $i.gff -f gff

defense-finder run $i.faa

grep 'chr_1' defense_finder_genes.tsv | cut -f 2 | sed  's/chr_//g'  > id.chr1
#grep 'chr_2' defense_finder_genes.tsv | cut -f4 | sed -e 's/^/2_/' > id.chr2
grep 'chr_2' defense_finder_genes.tsv | cut -f 2 | sed 's/chr_//g' > id.chr2


#cat id_chr1 id_chr2 > id.list

grep -f id.chr1 $i.gff -w | cut -f 1,2,4,5,7,8 > chr1.first.part.gff
grep 'chr_1' defense_finder_genes.tsv|sed 's/__/\tName=/g' | cut -f 3,4,17 > chr1.second.part.gff


grep -f id.chr2 $i.gff -w | cut -f 1,2,4,5,7,8 > chr2.first.part.gff
grep 'chr_2' defense_finder_genes.tsv|sed 's/__/\tName=/g' | cut -f 3,4,17 > chr2.second.part.gff

paste chr1.first.part.gff chr1.second.part.gff>chr1.unordered.gff
awk 'BEGIN {FS="\t"; OFS="\t"} {print $1, $2,$7,$3,$4,$9,$5,$6,$8 }' chr1.unordered.gff> chr1.prefinal.gff

paste chr2.first.part.gff chr2.second.part.gff>chr2.unordered.gff
awk 'BEGIN {FS="\t"; OFS="\t"} {print $1, $2,$7,$3,$4,$9,$5,$6,$8 }' chr2.unordered.gff> chr2.prefinal.gff


head $i.gff -n 1 > header

 n="${i%.fa}"   ##remove .fasta

cat header chr1.prefinal.gff > $n.chr1.gff
cat header chr2.prefinal.gff > $n.chr2.gff

cd ..
#mv $i ./$i.folder/

done

