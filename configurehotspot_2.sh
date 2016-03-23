
# Command to comment out a line in a file
# sed -e '/COMMENTMEOUT/ s/^#*/#/' -i FILENAME

################################################################
# The following instructions come from this page:
# https://learn.adafruit.com/setting-up-a-raspberry-pi-as-a-wifi-access-point/install-software

apt-get -y install vim
apt-get -y install hostapd udhcpd

# Set up DHCP server
