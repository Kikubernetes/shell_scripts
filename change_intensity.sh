#!/bin/bash

# Change image intensity as you like.
# Usage : change_intensity.sh Image.nii

# Check if image specified
if [[ -z $1 ]];then
    echo "Usage : change_intensity.sh Image.nii (or Image.nii.gz)"
    echo "Please specify a nifti image."
    exit 1
fi

# Check if image exists
if [[ ! -e $1 ]];then
    echo "$1 does not exist."
    exit 2
fi

# Read requested intensity Min to Max
echo "Please specify intensity you like."
read -p "Output Image intensity Minimum: " Min
read -p "Output Image intensity Maximum: " Max

# Current intensity is ImageMin to ImageMax
ImageMin=$(fslstats $1 -R | awk '{ print $1 }')
ImageMax=$(fslstats $1 -R | awk '{ print $2 }')

# Calculate image with fslmaths
imrange=$(python -c "print ($ImageMax-$ImageMin)")
range=$(python -c "print ($Max-$Min)")

fslmaths $1 -sub $ImageMin -div $imrange -mul $range -add $Min ic_$1

exit