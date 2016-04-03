#!/usr/bin/perl

use JSON;
use HTTPFunctions;

my $externalIP = `/usr/bin/wget -qO- http://ipecho.net/plain`;
my $parmsRef = HTTPFunctions->getQuerystringDictionary($ARGV[0]);
my %parms = %$parmsRef;

# You need to do the following:
# service nginx stop
# letsencrypt-auto certonly --standalone -d scottshouse.redirectme.net
# mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.notNeededAsSetupIsComplete
# mv /var/www/html /var/www/html.notNeededAsSetupIsComplete
# cp /home/pi/SKAD/files/guarddog.secure/default /etc/nginx/sites-available/
#TODO Need to replace the contents of the above default file with whatever domain/domains the SSL was generated for
# ln -s /home/pi/SKAD/html/guarddog.secure /var/www/html
# service nginx start

# NOTE: This call will not return a response because nginx was stopped above. So the Web page will have to wait a short while and then poll to see if the nginx server is back up and running

# Old code:
#my %wifiListHash = ( externalIP => $externalIP, domains => \@domainsArray );
#print encode_json(\%wifiListHash)."\n";

