mv /var/www/html /var/www/html.orig
ln -s ../html /var/www/html
gcc ../c/wrapper.c -o /home/pi/php_root
chown root /home/pi/php_root
chmod u=rwx,go=xr,+s /home/pi/php_root
