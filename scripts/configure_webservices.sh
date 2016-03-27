mv /var/www/html /var/www/html.orig
ln -s /home/pi/SKAD/html /var/www/html/guarddog/
ln -s /home/pi/SKAD/php /home/pi/SKAD/html/php
gcc ../c/wrapper.c -o /home/pi/php_root
chown root /home/pi/php_root
chmod u=rwx,go=xr,+s /home/pi/php_root
