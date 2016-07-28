#!/bin/bash
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install vim git
cd /home/pi
mkdir git
cd git
git clone https://github.com/scottclee/SKAD.git
cd /home/pi
ln -s ./git/SKAD SKAD
# chmod 755 ./SKAD/scripts/* # Shouldn't need to do this anymore as the file permissions should now be stored in github
sudo ./SKAD/scripts/expandRootFs.sh

###############################################################
# Note: Changing all this so it actually clones the code base instead of just downloading it. This should speed up the ability to make changes on directly on the pi if necessary

#if [ -z "$1" ]; then
#   echo "Parameters: <branch name>"
#   exit 1
#fi

#branch=$1
#cd /home/pi
#rm -fr SKAD-${branch}
#rm SKAD
#wget https://github.com/skad-io/skad-watch-dog/archive/${branch}.zip
#unzip ${branch}.zip
#rm ${branch}.zip
#ln -s SKAD-${branch} SKAD
#chmod +x SKAD/scripts/*.sh


