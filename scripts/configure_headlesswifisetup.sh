# Hints and tips:
#
# Command to comment out a line in a file
# sed -e '/COMMENTMEOUT/ s/^#*/#/' -i FILENAME
#
# Useful things for debugging:
# To run hostapd from the command line use:
# sudo hostapd /etc/hostapd/hostapd.conf

################################################################
# The following instructions come from this page:
# http://www.novitiate.co.uk/?p=183
#
# There was a missing instruction in the above link to set the value of DAEMON_CONF in hostapd and I found it in this:
# http://unix.stackexchange.com/questions/119209/hostapd-will-not-start-via-service-but-will-start-directly

apt-get -y install vim
apt-get -y install hostapd udhcpd

# Configure udhcpd (hands out IP addresses)
mv /etc/udhcpd.conf /etc/udhcpd.conf.orig
cp /home/pi/SKAD/files/headlesswifisetup/udhcpd.conf /etc/

cp /etc/default/udhcpd /etc/default/udhcpd.orig
sed -e '/DHCPD_ENABLED="no"/ s/^#*/#/' -i /etc/default/udhcpd

# Configure hostapd (the wireless access point)
mv /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf.orig
cp /home/pi/SKAD/files/headlesswifisetup/hostapd.conf /etc/hostapd/

mv /etc/default/hostapd /etc/default/hostapd.orig
cp /home/pi/SKAD/files/headlesswifisetup/hostapd /etc/default/

# Prevent udhcpd and hostapd from running on boot 
update-rc.d hostapd remove
update-rc.d udhcpd remove

mv /etc/rc.local /etc/rc.local.orig
cp /home/pi/SKAD/files/headlesswifisetup/rc.local /etc/

chmod +x /etc/rc.local

ln -s /home/pi/SKAD/html/headlesswifisetup /var/www/html.headlessModeFiles
# I believe the symbolic link is now stored in git
#ln -s /home/pi/SKAD/php /var/www/html.headlessMode/php
