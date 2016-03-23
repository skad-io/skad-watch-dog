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

# COnfigure udhcpd (hands out IP addresses)
mv /etc/udhcpd.conf /etc/udhcpd.conf.orig

echo 'start 192.168.0.2 # This is the range of IPs that the hotspot will give to client devices.' >> /etc/udhcpd.conf
echo 'end 192.168.0.20' >> /etc/udhcpd.conf
echo 'interface wlan0 # The device udhcp listens on.' >> /etc/udhcpd.conf
echo 'remaining yes' >> /etc/udhcpd.conf
echo 'opt dns 8.8.8.8 4.2.2.2 # The DNS servers client devices will use.' >> /etc/udhcpd.conf
echo 'opt subnet 255.255.255.0' >> /etc/udhcpd.conf
echo 'opt router 192.168.0.1 # The Pis IP address on wlan0 which we will set up shortly.' >> /etc/udhcpd.conf
echo 'opt lease 864000 # 10 day DHCP lease time in seconds' >> /etc/udhcpd.conf

cp /etc/default/udhcpd /etc/default/udhcpd.orig
sed -e '/DHCPD_ENABLED="no"/ s/^#*/#/' -i /etc/default/udhcpd

# Configure hostapd (the wireless access point)
mv /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf.orig

echo 'interface=wlan0' >> /etc/hostapd/hostapd.conf
echo 'driver=nl80211' >> /etc/hostapd/hostapd.conf
echo 'ssid=Raspi_wifi' >> /etc/hostapd/hostapd.conf
echo 'hw_mode=g' >> /etc/hostapd/hostapd.conf
echo 'channel=11' >> /etc/hostapd/hostapd.conf
echo 'macaddr_acl=0' >> /etc/hostapd/hostapd.conf
echo 'auth_algs=1' >> /etc/hostapd/hostapd.conf
echo 'ignore_broadcast_ssid=0' >> /etc/hostapd/hostapd.conf
echo 'wpa=2' >> /etc/hostapd/hostapd.conf
echo 'wpa_passphrase=somepassword' >> /etc/hostapd/hostapd.conf
echo 'wpa_key_mgmt=WPA-PSK' >> /etc/hostapd/hostapd.conf
echo 'wpa_pairwise=TKIP' >> /etc/hostapd/hostapd.conf
echo 'rsn_pairwise=CCMP' >> /etc/hostapd/hostapd.conf

mv /etc/hostapd/hostapd.conf /etc/hostapd/hostapd.conf.orig

echo 'DAEMON_CONF="/etc/hostapd/hostapd.conf"' >> /etc/hostapd/hostapd.conf

# Prevent udhcpd and hostapd from running on boot 
update-rc.d hostapd remove
update-rc.d udhcpd remove

mv /etc/rc.local /etc/rc.local.orig

echo '#!/bin/sh -e' >> /etc/rc.local
echo '#' >> /etc/rc.local
echo '#' >> /etc/rc.local
echo '# This script is executed at the end of each multiuser runlevel.' >> /etc/rc.local
echo '# Make sure that the script will "exit 0" on success or any other' >> /etc/rc.local
echo '# value on error.' >> /etc/rc.local
echo '#' >> /etc/rc.local
echo '# In order to enable or disable this script just change the execution' >> /etc/rc.local
echo '# bits.' >> /etc/rc.local
echo '#' >> /etc/rc.local
echo '# By default this script does nothing.' >> /etc/rc.local
echo '' >> /etc/rc.local
echo '# Print the IP address' >> /etc/rc.local
echo 'sleep 5' >> /etc/rc.local
echo '_IP=$(hostname -I) || true' >> /etc/rc.local
echo 'if [ "$_IP" ]; then' >> /etc/rc.local
echo '  printf "My IP address is %s\n" "$_IP"' >> /etc/rc.local
echo 'fi' >> /etc/rc.local
echo '' >> /etc/rc.local
echo 'if [ "$_IP" ]; then' >> /etc/rc.local
echo '      echo "[Access Point Setup] - The wifi is already connected, no access point needed"' >> /etc/rc.local
echo '         else' >> /etc/rc.local
echo '      echo "[Access Point Setup] - The wifi is not connected, firing up an access point..."' >> /etc/rc.local
echo '      sudo ifconfig wlan0 192.168.0.1' >> /etc/rc.local
echo '      sudo service hostapd start' >> /etc/rc.local
echo '      sudo service udhcpd start' >> /etc/rc.local
echo '   fi' >> /etc/rc.local

chmod +x /etc/rc.local

