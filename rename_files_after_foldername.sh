#!/bin/bash

# 複数の被験者フォルダから画像をコピーしてリネームし一つのフォルダに集める。
# Copy the images you want from multiple subject folders, rename them, and collect them in one folder.

# 全ての被験者が同じディレクトリ構造であることが必要。
# All subjects need to have the same directory structure.

# スクリプトで使われる変数はほしい画像に応じて変更する。
# Change variables used in this script according to the images you want.

#------------------書き換える部分はここから-------------------------------#
#==================Variables==========================================#
original_dir=~/prac/Original
file_name=file1
new_dir=~/prac/New
new_name=file
#-------------------ここまで--------------------------------------------#

# sublistを作る
sublist=$(ls $original_dir)
echo "Sublist is $sublist"

for sub in $sublist
do
    cp -r $original_dir/$sub/$file_name $new_dir/${sub}_$new_name
done

