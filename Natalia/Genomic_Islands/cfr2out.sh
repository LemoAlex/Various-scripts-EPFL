#!/bin/bash
for i in *.gff
do
grep 'PUTAL' $i | tail -n +2 |cut -f 3,4,5| sed 's/\t/../g'| sed 's/PUTAL../Misc\t/g' | sed 's/Misc/ \t\/note="SigCRF" \n Misc/g'| tail -n +2 | sed '$s/$/\n \t\/note="SigCRF"/' > $i.CRF.out 
done

