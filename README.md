# shell_scripts <!-- omit in toc -->
Shell scripts for daily use.
Mainly related to brain image analysis.

## Table of Contents <!-- omit in toc -->

- [syncview](#syncview)
- [timelog](#timelog)
- [change\_intensity.sh](#change_intensitysh)
- [new\_datadir.sh](#new_datadirsh)
  - [example](#example)
- [rename\_files\_after\_foldername.sh](#rename_files_after_foldernamesh)
- [gif\_movie\_to\_still.sh](#gif_movie_to_stillsh)
- [png\_tilemake.sh](#png_tilemakesh)
- [label\_list\_maker.sh](#label_list_makersh)
- [first.sh](#firstsh)


## syncview

**prerequisite : Mrtrix3 and zenity**

You can view nii and mif files in multiple windows with syncronized slice position (if they were performed at the same position and date)

**usage**

You can see help with this command.

```syncview h```

## timelog

**prerequisite : nothing special**

**usage**

```timelog your_script_to_record_time```

You can measure and record runtime of your script in timelog.txt, which is generated in the working directory.

## change_intensity.sh

**prerequisite : FSL (any version)**

**usage**

```Usage : change_intensity.sh Image.nii (or Image.nii.gz)```

You can specify Minimum and Maximum intensity of nifti image.

## new_datadir.sh

**prerequisite : nothing special**


Create a new data directory by collecting specific files or directories from the subject data. This is useful when you want to do another analysis using the same data, or when you want to start over in the middle of an analysis.

There is a "Variables" section in the script that allows you to specify the original subject data directory, what to copy in it, and the new subject data directory, respectively. Please rewrite this section to suit your environment.

After that, move to the directory (clone of this repository) and execute ：

```bash
cd ~/git/shell_scripts
./new_datadir.sh
```
### example

If you have file tree like this:

<img src="images/image_2023-07-30_11-52-31.png" width="200">

And if you want dir1 and dir2/file1 to be copied, modify variables like:

```bash
###--------------------Variables---------------------###
original_directory=~/ori
new_directory=~/new
f_and_d=(dir1 dir2/file1)
########################################################
```
<img src="images/image_2023-07-30_11-55-09.png" width="150">

## rename_files_after_foldername.sh
**prerequisite : nothing special**

This is a script that takes the name of a folder and use it as a file name. For example, it can be used to collect FA.nii.gz for each subject in order to perform TBSS. See the following example for how to use it.

Example: In the Original folder, there are folders named after the subjects sub001-sub003. Each folder contains files with the same name, file1-3. If you want to collect all file1 into one folder (New folder), you may give each file a subject name, since files with the same name will be overwritten.


<img src="images/image230809-160540.png" width=150>


There is a "Variables" section in the script that allows you to specify the original folder, what to copy in it, the new folder, and the new name, respectively. Please rewrite this section to suit your environment.

```
#==================Variables=========================#
original_dir=~/Original
file_name=file1
new_dir=~/New
new_name=file
```

Then go to the directory where you cloned this repository (e.g. ~/git/shell_scripts) and type the following to execute.

```bash
cd ~/git/shell_scripts
./rename_files_after_foldername.sh
```

The resulting New folder will look like this

<img src="images/image230809-162820.png" width=160>

## gif_movie_to_still.sh

**prerequisite : ImageMagick(https://imagemagick.org/index.php)**

**usage**

```
cd directory_with_animated_gif
png_tilemake.sh

```

This script does frame decomposition of animated gif.
Prepare animatd gif(s) in the current working directory.
You can decompose more than one gif. A folder will be made for each of them, and the decomposed images will go into that folder. The original images will go in a folder named original_gifs. By default, they are saved in png format, so if you want gifs, switch the comment out.


## png_tilemake.sh

**prerequisite : FSL**

**usage**

```
png_tilemake.sh
```

Create tile-like images from png images. Each tile can contain 2-6 images. The name of the image must contain a 4-digit serial number starting with 0000. For example, "image0001.png" or "DWI_0100.png". If you decompose an animated gif that can be saved in fsleyes with gif_movie_to_still.sh in this repository, or if you save an image in mrview, it will be given a name that matches the criteria by default.


## label_list_maker.sh

Make a label list from xml file of FSL atlases.
When you download and run the program, a list of atlases will appear and you will be asked which one you want to make, so copy and paste the name including the extension and return.
```
./label_list_maker.sh
```

## first.sh

Simole wrapper of dcm2niix, which converts dicom to nifti and organizes directory.

**prerequisite : dcm2niix**

**usage**

```
cd dicom_directory
first.sh
```