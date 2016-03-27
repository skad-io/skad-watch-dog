#!/bin/sh

/bin/echo "Parameters: ${1}"
echo "<BR>"
/usr/bin/perl -I/home/pi/SKAD/perl /home/pi/SKAD/perl/getNginxServerConfigs.pl
