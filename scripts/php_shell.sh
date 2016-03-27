#!/bin/sh

/bin/echo "Parameters: ${1}"
echo "<BR>"
/usr/bin/perl -I/home/pi/SKAD-wifi-hotspot-scripts/perl /home/pi/SKAD-wifi-hotspot-scripts/perl/getNginxServerConfigs.pl
