#!/bin/bash
# This program is to convert DICOM to NIFTI with dcm2niix.
# Original data will be put into org_data and niftis into nifti_data.
# Please start in the directory containing DICOM files.
# Written by Kikuko Kaneko and modified on 11/15/2023.

# get ImageID
ImageID=${PWD##*/}
date

# mkdir & move file
mkdir org_data nifti_data
dicom=$(find . -mindepth 1 -maxdepth 1 -path './nifti_data' -prune \
 -o -path './org_data' -prune -o -print)
mv $dicom ./org_data

# dcm2niix
dcm2niix -f %d -o ./nifti_data ./org_data

