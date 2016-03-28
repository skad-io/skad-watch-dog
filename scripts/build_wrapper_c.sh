outputDirectory=/home/pi

# Allow overriding of output directory for testing this scripts
if [ -e "$1" ]; then
	outputDirectory=$1   
fi

gcc ../c/wrapper.c -o ${outputDirectory}/php_root
sudo chown root ${outputDirectory}/php_root
sudo chmod u=rwx,go=xr,+s ${outputDirectory}/php_root
