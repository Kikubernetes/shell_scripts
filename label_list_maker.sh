#!/bin/bash

# Make a label list from xml file of FSL atlases.

echo "This script makes a label list for FSL atlases."
echo "This is the list of xmlfiles of FSL atlases."
ls $FSLDIR/data/atlases | grep xml
read -p " Please enter one of the name above. > " xmlname

if [[ -z $xmlname ]]; then
    echo "Please specify xml file."
    exit
elif [[ ! -f $FSLDIR/data/atlases/$xmlname ]]; then
    echo "This file does not exist. Please include the extension .xml"
    exit
else :
fi
atlas=$(echo ${xmlname##*/} | sed 's/\.xml//')
cat $FSLDIR/data/atlases/$xmlname | grep "<label index" | grep -v Unclassified |\
 cut -d ">" -f 2 | cut -d "<" -f 1 > ${atlas}_label.txt

# probabilistic or deterministic
atlaskind=$(cat $FSLDIR/data/atlases/$xmlname | grep "<type>" | \
cut -d ">" -f 2 | cut -d "<" -f 1 )

# determining index number
if [[ $atlaskind = Label ]]; then
    cat $FSLDIR/data/atlases/$xmlname | grep "<label index" | grep -v Unclassified |\
    cut -d ">" -f 1 | cut -d "=" -f 2 | tr -d '" x' > ${atlas}_index.txt
elif [[ $atlaskind = Probabilistic ]]; then
    cat $FSLDIR/data/atlases/$xmlname | grep "<label index" | grep -v Unclassified |\
    cut -d ">" -f 1 | cut -d "=" -f 2 | tr -d '" x' > tmp_${atlas}_index.txt
    indexnum=$(cat tmp_${atlas}_index.txt | wc -l)
    seq $indexnum > ${atlas}_index.txt
else 
    echo "Cannot determine index number. Output text is label name only."
fi

paste ${atlas}_index.txt ${atlas}_label.txt > ${atlas}_label_list.txt
rm -rf tmp* ${atlas}_label.txt ${atlas}_index.txt

echo "Finished. You will find ${atlas}_label_list.txt in this directory."

exit