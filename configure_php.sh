# Kudos to this tutorial:
# https://www.howtoforge.com/tutorial/installing-nginx-with-php-fpm-and-mariadb-lemp-on-debian-jessie/

apt-get install php5-fpm

# cp /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
# It says to change keepalive_timeout to 2 seconds but not sure why so not doing it for now

cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.orig

echo 'These commands dont seem to be working'

sed -e 's/#location ~ \.php$ {/location ~ \.php$ {/g' -i /etc/nginx/sites-available/default
sed -e 's/#       include snippets\/fastcgi-php.conf;/       include snippets\/fastcgi-php.conf;/g' -i /etc/nginx/sites-available/default
sed -e 's/#       fastcgi_pass unix:\/var\/run\/php5-fpm.sock;/       fastcgi_pass unix:\/var\/run\/php5-fpm.sock;/g' -i /etc/nginx/sites-available/default
sed -e 's/#location ~ \/\\.ht {/location ~ \/\\.ht {/g' -i /etc/nginx/sites-available/default
sed -e 's/#       deny all;/       deny all;/g' -i /etc/nginx/sites-available/default

systemctl reload nginx.service

