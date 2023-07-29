#!/bin/bash

# This script is to set up a new data directory of nifti data
# copied from original directory.
# Written by Kikuko K at 20230724.

###---------------Variables------------------###
original_directory=/media/kikuko/kotatsu/SR/data
new_directory=/media/kikuko/kotatsu/SR/syn_data
################################################

sublist=$(ls $original_directory)

for sub in $sublist; do
    mkdir -p $new_directory/$sub
    cp -r $original_directory/$sub/nifti_data $new_directory/$sub

done

exit