
# Command to comment out a line in a file
# sed -e '/COMMENTMEOUT/ s/^#*/#/' -i FILENAME

apt-get -y install vim
apt-get -y install hostapd isc-dhcp-server

# Set up DHCP server
cp /etc/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf.orig
sed -e '/option domain-name "example.org";/ s/^#*/#/' -i /etc/dhcp/dhcpd.conf
sed -e '/option domain-name-servers ns1.example.org, ns2.example.org;/ s/^#*/#/' -i /etc/dhcp/dhcpd.conf

