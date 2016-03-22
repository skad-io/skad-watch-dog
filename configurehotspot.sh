
# Command to comment out a line in a file
# sed -e '/COMMENTMEOUT/ s/^#*/#/' -i FILENAME

################################################################
# The following instructions come from this page:
# https://learn.adafruit.com/setting-up-a-raspberry-pi-as-a-wifi-access-point/install-software

apt-get -y install vim
apt-get -y install hostapd isc-dhcp-server

# Set up DHCP server
cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.orig
sed -e '/option domain-name "example.org";/ s/^#*/#/' -i /etc/dhcp/dhcpd.conf
sed -e '/option domain-name-servers ns1.example.org, ns2.example.org;/ s/^#*/#/' -i /etc/dhcp/dhcpd.conf

echo '# If this DHCP server is the official DHCP server for the local' >> /etc/dhcp/dhcpd.conf
echo '# network, the authoritative directive should be uncommented.' >> /etc/dhcp/dhcpd.conf
echo 'authoritative;' >> /etc/dhcp/dhcpd.conf
echo '' >> /etc/dhcp/dhcpd.conf
echo 'subnet 192.168.42.0 netmask 255.255.255.0 {' >> /etc/dhcp/dhcpd.conf
echo '	range 192.168.42.10 192.168.42.50;' >> /etc/dhcp/dhcpd.conf
echo '	option broadcast-address 192.168.42.255;' >> /etc/dhcp/dhcpd.conf
echo '	option routers 192.168.42.1;' >> /etc/dhcp/dhcpd.conf
echo '	default-lease-time 600;' >> /etc/dhcp/dhcpd.conf
echo '	max-lease-time 7200;' >> /etc/dhcp/dhcpd.conf
echo '	option domain-name "local";' >> /etc/dhcp/dhcpd.conf
echo '	option domain-name-servers 8.8.8.8, 8.8.4.4;' >> /etc/dhcp/dhcpd.conf
echo '}' >> /etc/dhcp/dhcpd.conf

# Now change a different file
cp /etc/default/isc-dhcp-server /etc/default/isc-dhcp-server.orig
sed -i 's/INTERFACES=""/INTERFACES="wlan0"/g' /etc/default/isc-dhcp-server

# Note: See if you can simplify the above by revisiting the following page which didn't work for you the first time you tried it
# http://www.novitiate.co.uk/?p=183

