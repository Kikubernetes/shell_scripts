# shell_scripts
Shell scripts for daily use.

Mainly related to brain image analysis.

## syncview

**prerequisite for syncview: Mrtrix3 and zenity.**

You can view nii and mif files in multiple windows with syncronized slice position (if they were performed at the same position and date)

**usage**

You can see help with this command.

```syncview h```

## timelog

**prerequisite for timelog: nothing special**

**usage**

```timelog your_script_to_record_time```

You can measure and record runtime of your script in timelog.txt, which is generated in the working directory.

## change_intensity.sh

**prerequisite for change_intensity.sh: FSL (any version)**

**usage**

```Usage : change_intensity.sh Image.nii (or Image.nii.gz)```

You can specify Minimum and Maximum intensity of nifti image.

## new_datadir.sh

**prerequisite: nothing special**


被験者データの中から特定のファイルやディレクトリを集めて新たなデータディレクトリを作成します。同じデータを使って別の解析をやりたい時、もしくは途中から解析をやり直したい時に便利です。

スクリプト内に「変数」という項目があり、元となる被験者データのディレクトリ、その中の何をコピーするか、新しい被験者データのディレクトリをそれぞれ指定できるようになっています。ご自分の環境に合わせてこの部分を書き換えてください。コピーするディレクトリ名、ファイル名は半角スペースで区切って()の中に記載します。

その後このレポジトリをクローンしたディレクトリに移動して下記で行うと実行されます。

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

これはフォルダーの名前をとってファイル名にするスクリプトです。例えばTBSSを行うために各被験者のFA.nii.gzを集めるのに使えます。使い方は次の例を見てください。

例：
今Originalフォルダ内に被験者sub001-sub003のフォルダがあります。各フォルダ内には同名のファイル、file1-3が含まれています。もし全てのfile1を１つのフォルダ（Newフォルダ）に集めたい場合、同名のファイルは上書きされてしまうため、各ファイルに被験者名をつけることができます。

This is a script that takes the name of a folder and use it as a file name. See the following example for how to use it.

Example: In the Original folder, there are folders named after the subjects sub001-sub003. Each folder contains files with the same name, file1-3. If you want to collect all file1 into one folder (New folder), you may give each file a subject name, since files with the same name will be overwritten.


<img src="images/image230809-160540.png" width=150>

スクリプト内に「変数」という項目があり、元となるフォルダ、その中の何をコピーするか、新しいフォルダ、新しい名前をそれぞれ指定できるようになっています。ご自分の環境に合わせてこの部分を書き換えてください。

There is a "Variables" section in the script that allows you to specify the original folder, what to copy in it, the new folder, and the new name, respectively. Please rewrite this section to suit your environment.

```
#-------------書き換える部分はここから-------------------#
#==================Variables=========================#
original_dir=~/Original
file_name=file1
new_dir=~/New
new_name=file
#-------------------ここまで---------------------------#
```

その後このレポジトリをクローンしたディレクトリ（例えば~/git/shell_scripts）に移動して下記をタイプすると実行されます。

Then go to the directory where you cloned this repository (e.g. ~/git/shell_scripts) and type the following to execute.

```bash
cd ~/git/shell_scripts
./rename_files_after_foldername.sh
```

出来上がったNewフォルダは以下のようになります。

The resulting New folder will look like this

<img src="images/image230809-162820.png" width=160>