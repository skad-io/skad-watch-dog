./install_packages.sh
./configure_core.sh
./configure_nginx.sh
./configure_php.sh
./configure_cpanJson.sh
./configure_webservices.sh
./configure_headlesswifisetup.sh
./configure_expandRootFs.sh
./configure_hostname.sh guarddog
mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.orig
cp /home/pi/SKAD/files/guarddog/default /etc/nginx/sites-available/
echo "Please reboot me now"
