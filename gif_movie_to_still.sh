#!/bin/bash

# This script does frame decomposition of animated gif.
# Prepare animatd gifs in the current directory.
# Prerequisite is ImageMagick(https://imagemagick.org/index.php).
# If you want pngs rather than gifs, switch comment outed lines
# around line 27 to 31.
# Written by Kikuko Kaneko on Aug 27 2023.

animated_gif=($(ls *.gif))

# check if gif exists
if [ ${#animated_gif[@]} -eq 0 ]; then
  echo "It seems no gif exists in this directory."
  exit
fi
echo "${animated_gif[@]} will be converted."
[[ ! -d original_gifs ]] && mkdir original_gifs

# convert gifs
for gif_name in ${animated_gif[@]}
    do
        # mkdir ${gif%%.*}s
        gif=$(echo $gif_name | sed 's/.gif//')
        [[ -d ${gif}s ]] && mv ${gif}s ${gif}s_ex
        mkdir ${gif}s
        #convert +adjoin $gif_name -coalesce $gif%03d.png
        convert +adjoin $gif_name -coalesce $gif%03d.gif
        mv $gif_name original_gifs/
        #mv $gif*.png ${gif}s/
        mv $gif*.gif ${gif}s/
    done


echo "finished!"
