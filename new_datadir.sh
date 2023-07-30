#!/bin/bash

# This script is to set up a new data directory of nifti data
# copied from original directory.
# Written by Kikuko K at 20230724.

###--------------------Variables---------------------###
original_directory=path_to_the_original_data_directory
new_directory=path_to_the_new_data_directory
f_and_d=(file_name or directory_name, space seperated)
########################################################


echo "${f_and_d[@]} will be copied to $new_directory."
sublist=$(ls $original_directory)
echo "Subject list: $sublist"

for sub in $sublist; do
    mkdir -p $new_directory/$sub
    for file in ${f_and_d[@]}
    do
        cp -r $original_directory/$sub/$file $new_directory/$sub
    done
done

exit