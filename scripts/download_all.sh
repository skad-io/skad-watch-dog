if [ -z "$1" ] || [ -z "$2" ]; then
   echo "Parameters: <branch name>"
   exit 1
fi

branch=$1
wget https://github.com/scottclee/SKAD/archive/${branch}.zip
unzip ${branch}.zip
rm ${branch}.zip
rm SKAD
ln -s SKAD-${branch} SKAD
chmod +x SKAD/scripts/*.sh
