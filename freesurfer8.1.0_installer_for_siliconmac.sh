#!/bin/bash
# Script to install freesurfer
# This script downloads required files, install them, 
#  and configure that subject directory is under $HOME

# 15 Aug 2025 K. Nemoto
# 7 Sep 2025 K. Kaneko modified

# Changelog
# 15-Aug-2025 modify the script with the release of 8.1.0
# 11-May-2025 modify the script with the release of 8.0.0
# 08-Feb-2025 modify the script with the release of 8.0.0-beta

# For debug
#set -x

## Variables #########################################################
ver=8.1.0
macOS=arm64
pkg="freesurfer-macOS-darwin_${macOS}-${ver}.pkg"
url="https://surfer.nmr.mgh.harvard.edu/pub/dist/freesurfer/${ver}/${pkg}"
curlcmd="curl -O -C -"
md5="8bbf749af50e4bdb8d25f6a40ca63af3"
# md5 values can be obtained from the link below.
# https://surfer.nmr.mgh.harvard.edu/fswiki/rel7downloads
######################################################################


echo "Begin installation of FreeSurfer"
echo ""
echo "This script will download and install Freesurfer in mac"
echo "You need to prepare license.txt beforehand."
echo "license.txt should be placed in $HOME/Downloads"


while true; do

echo "Are you sure you want to begin the installation of FreeSurfer? (yes/no)"
read answer 
    case $answer in
        [Yy]*)
          echo "Begin installation."
	  break
          ;;
        [Nn]*)
          echo "Abort installation."
          exit 1
          ;;
        *)
          echo -e "Please type yes or no. \n"
          ;;
    esac
done


# Check if one wants to modify recon-all for VirtualBox environment
while true; do
echo "Do you want to modify recon-all for VirtualBox environment? (yes/no)"
read answer
    case $answer in
        [Yy]*)
          echo "modify recon-all later."
          reconallvb=1
          break
          ;;
        [Nn]*)
          echo "will not modify recon-all."
          break
          ;;
        *)
          echo -e "Please type yes or no. \n"
          ;;
    esac
done


cd $HOME/Downloads


# Download freesurfer
if [ ! -e $HOME/Downloads/${pkg} ]; then
	echo "Download Freesurfer to $HOME/Downloads"
	cd $HOME/Downloads
        eval $curlcmd $url
else
	echo "Freesurfer archive is found in $HOME/Downloads"
fi


# Check the archive
cd $HOME/Downloads
echo "Check if the downloaded archive is not corrupt."
echo "${md5} ${pkg}" > ${pkg}.md5
md5sum -c ${pkg}.md5
while [ "$?" -ne 0 ]; do
    echo "Filesize is not correct. Re-try downloading."
    sleep 5
    eval $curlcmd $url
    md5sum -c ${pkg}.md5
done

echo "Filesize is correct!"
rm ${pkg}.md5

# Install freesurfer
echo "Install freesurfer"
sudo installer -pkg $HOME/Downloads/${pkg} -target /

# Prepare freesurfer directory in $HOME
echo "make freesurfer directory in $HOME"
cd $HOME

if [ ! -d $HOME/freesurfer/$ver/subjects ]; then
    mkdir -p $HOME/freesurfer/$ver/subjects
fi

cp -ar /usr/local/freesurfer/$ver/subjects $HOME/freesurfer/$ver/

# Append to .bash_profile
if [ -f $HOME/.bash_profile ]; then
  grep freesurfer/$ver $HOME/.bash_profile > /dev/null
  if [ "$?" -eq 0 ]; then
    echo ".bash_profile is already set."
  else
    echo >> $HOME/.bash_profile
    echo "#FreeSurfer $ver" >> $HOME/.bash_profile
    echo "export SUBJECTS_DIR=~/freesurfer/$ver/subjects" >> $HOME/.bash_profile
    echo "export FREESURFER_HOME=/usr/local/freesurfer/$ver" >> $HOME/.bash_profile
    echo "export FS_LICENSE=$HOME/freesurfer/license.txt" >> $HOME/.bash_profile
    echo 'source $FREESURFER_HOME/SetUpFreeSurfer.sh' >> $HOME/.bash_profile
  fi
fi


# Replace 'ln -s' and 'ln -sf' with 'cp' in recon-all, trac-preproc, gcaprepone, 
#  and make_average_{subject,surface,volume} for virtualbox environment
if [ "$reconallvb" == 1 ]; then
  sudo sed -i 's/ln -sf/cp/' /usr/local/freesurfer/$ver/bin/recon-all
  sudo sed -i 's/ln -s \$hemi/cp \$hemi/' /usr/local/freesurfer/$ver/bin/recon-all
  sudo sed -i 's/ln -s \$FREESURFER_HOME\/subjects\/fsaverage/cp -r \$FREESURFER_HOME\/subjects\/fsaverage \$SUBJECTS_DIR/' /usr/local/freesurfer/$ver/bin/recon-all
  sudo sed -i 's/ln -s \$FREESURFER_HOME\/subjects\/\${hemi}.EC_average/cp -r \$FREESURFER_HOME\/subjects\/\${hemi}.EC_average \$SUBJECTS_DIR/' /usr/local/freesurfer/$ver/bin/recon-all
#  sudo sed -i 's/ln -sfn/cp/' /usr/local/freesurfer/$ver/bin/trac-preproc
#  sudo sed -i 's/ln -sf/cp/' /usr/local/freesurfer/$ver/bin/trac-preproc
#  sudo sed -i 's/ln -s/cp/' /usr/local/freesurfer/$ver/bin/trac-preproc
  sudo sed -i 's/ln -s/cp/' /usr/local/freesurfer/$ver/bin/gcaprepone
  sudo sed -i 's/ln -s/cp/' /usr/local/freesurfer/$ver/bin/make_average_subject
  sudo sed -i 's/ln -s/cp/' /usr/local/freesurfer/$ver/bin/make_average_surface
  sudo sed -i 's/ln -s/cp/' /usr/local/freesurfer/$ver/bin/make_average_volume
fi

# Workaround for FSL configuration
# Check FSL version
#fslver=$(cat $FSLDIR/etc/fslversion | sed 's/\.//g')
#if [[ $fslver -ge 6061 ]]; then
#  sudo sed -i 's@export FSL_BIN=$FSL_DIR/bin@export FSL_BIN=$FSL_DIR/share/fsl/bin@' /usr/local/freesurfer/${ver}/FreeSurferEnv.sh 
#fi

echo "Check if you have license.txt in $HOME/Downloads"

if [ -e $HOME/Downloads/license.txt ]; then
    echo "license.txt will be copied to $HOME/freesurfer/"
    cp $HOME/Downloads/license.txt $HOME/freesurfer/
else
    echo "You need to prepare license.txt"
    echo "from the following window and put it in $HOME/freesurfer/"
    xdg-open "https://surfer.nmr.mgh.harvard.edu/registration.html" 
fi

echo "Installation finished!"
echo "If you have installed previous version of FreeSurfer, please check"
echo "~/.bash_profile and comment out the previous version"
echo "Now close this terminal, open another terminal, then run freeview."

exit

