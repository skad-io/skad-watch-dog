cp ../php/*.php /var/www/html/
gcc ../c/wrapper.c -o /home/pi/php_root
chown root /home/pi/php_root
chmod u=rwx,go=xr,+s /home/pi/php_root
cp php_shell.sh /home/pi/
