#!/bin/bash

# Make tiles from mrview screen captured pngs.
# Minimum 2 series to Maximum 6 series.
# First save pngs (same number in each folder is favorable).
# mrviewのScreenCaptureでスライドにしたいpng画像を保存して下さい。
# 一枚のスライドに2−6枚の画像を並べることができます。

# get folder name of pngs
read -p "png画像のフォルダー名をスペースで区切って入力してください> " -a ary
numary=${#ary[@]}
num=$(ls ${ary[0]} | wc -l)
lastcount=$((num-1))
echo "${ary[@]}の${numary}個のフォルダーの画像からタイル画像を作ります"
echo "画像の名前は0000から始まる4桁の通し番号を含んでいる必要があります"
echo "例えば「image0001.png」 や 「DWI_0100.png」などです"
echo "画像の枚数は1つ目のフォルダーにある画像の枚数 $num に合わせます"

[[ -d tiles ]] && mv tiles tiles_ex

case $numary in
    [0-1])  echo "2-6 folderを選んでください。"
            exit ;;
    2)
    for i in `seq -f "%04g" 0 1 $lastcount`; do
	    pngappend \
	    ${ary[0]}/*${i}.png + \
        ${ary[1]}/*${i}.png  \
        tile$i.png 
    done
     ;;
    3)
    for i in `seq -f "%04g" 0 1 $num`; do
	    pngappend \
	    ${ary[0]}${i}.png + \
        ${ary[1]}${i}.png + \
        ${ary[2]}${i}.png  \
        tile$i.png 
    done
     ;;
    4)
    for i in `seq -f "%04g" 0 1 $num`; do
	    pngappend \
	    ${ary[0]}${i}.png + \
        ${ary[1]}${i}.png + \
        ${ary[2]}${i}.png - \
        ${ary[3]}${i}.png  \
        tile$i.png 
    done
     ;;
    5)
    for i in `seq -f "%04g" 0 1 $num`; do
	    pngappend \
	    ${ary[0]}${i}.png + \
        ${ary[1]}${i}.png + \
        ${ary[2]}${i}.png - \
        ${ary[3]}${i}.png + \
        ${ary[4]}${i}.png  \
        tile$i.png 
    done
     ;;
    6)  
    for i in `seq -f "%04g" 0 1 $num`; do
	    pngappend \
	    ${ary[0]}${i}.png + \
        ${ary[1]}${i}.png + \
        ${ary[2]}${i}.png - \
        ${ary[3]}${i}.png + \
        ${ary[4]}${i}.png + \
        ${ary[5]}${i}.png \
        tile$i.png 
    done
     ;;
     *) echo "2-6種類の画像を選んでください。" 
        exit ;;
esac 2>/dev/null

mkdir tiles
mv tile*.png tiles/
exit
