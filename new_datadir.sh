#!/bin/bash

# This script is to set up a new data directory of nifti data
# copied from original directory.
# Written by Kikuko K at 20230724.

###---------------Variables------------------###
original_directory=path_to_the_original_data_directory
new_directory=path_to_the_new_data_directory
f_and_d=file_name or directory_name
################################################

sublist=$(ls $original_directory)

for sub in $sublist; do
    mkdir -p $new_directory/$sub
    cp -r $original_directory/$sub/$f_and_d $new_directory/$sub

done

exit