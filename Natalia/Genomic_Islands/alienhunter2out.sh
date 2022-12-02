#!/bin/bash
for i in *.alienhunter
do
grep 'misc' $i | sed 's/misc_feature/Misc/g' | sed 's/FT/ \t \/note="alienhunter" \n/g' | tail -n +2 | sed '$s/$/\n \t \/note="alienhunter"/' > $i.out
done

