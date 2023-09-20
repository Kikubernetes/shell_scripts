#!/bin/bash

# 各画像から矢状断で正中となるスライスを見つけてPNGとして切り出す。
# 次にそれを集めて並べた画像を作る。

# Find the median slice in the sagittal section of each 3D image volume and cut it out as a PNG.
# Next, collect them and make a tile-like image.

#------------------書き換える部分はここから-----You can modify from here----------------

# 参照画像。切り出したい画像の種類と同じにする(必要なもの以外をコメントアウトする)。
# Reference image. The same as the type of image you want to crop (comment out everything except what you need).
ref=${FSLDIR}/data/standard/MNI152_T1_1mm.nii.gz        # T1WI
#ref=${FSLDIR}/data/atlases/JHU/JHU-ICBM-T2-2mm.nii.gz  # T2WI or b0

# 画像ディレクトリ
image_dir=/media/kikuko/kotatsu/SR/T1w2

#----------------------------------ここまで-----to here----------------------------------

cd $image_dir
for f in $(ls)
  do
   flirt -dof 6 -in $f -ref $ref -out r${f}
   slicer r$f -s 3 -x 0.5 $f.png
  done

#Prepare argument for pngappend
  inputarg=`ls *.png | \
    awk '{ if (NR%5==1) {print " - " $0} else {print " + " $0} }' | \
    tr -d '\n' | sed 's/-//'`
 
  #For debug
  #  echo $inputarg
 
  #Append png files 
  pngappend $inputarg LightBox.png
   
  #Delete temporary files
  #rm ${file}_???.png
  #rm r$f