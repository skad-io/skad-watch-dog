#!/usr/bin/perl

use JSON;
use HTTPFunctions;
use NginxConfigFunctions;

my $parmsRef = HTTPFunctions->getQuerystringDictionary($ARGV[0]);
my %parms = %$parmsRef;
my @domains = split / /, $parms{domains};
my $domainsString = "";

foreach $domain (@domains) {
	$domainsString .= "-d $domain";
}

# You need to do the following:
`/usr/sbin/service nginx stop`;

# Going to write the output to a file as we will be unable to return it to the browser due to stopping nginx

`/bin/echo "domainsString = $domainsString" > /tmp/delme.txt`;
`/opt/letsencrypt/letsencrypt-auto --config /etc/letsencrypt/cli.ini certonly --standalone $domainsString >> /tmp/delme.txt`;
#`/opt/letsencrypt/letsencrypt-auto --dry-run --config /etc/letsencrypt/cli.ini certonly --standalone $domainsString >> /tmp/delme.txt`;

`/bin/mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.notNeededAsSetupIsComplete`;
`/bin/mv /var/www/html /var/www/html.notNeededAsSetupIsComplete`;
`/bin/cp /home/pi/SKAD/files/guarddog.secure/default /etc/nginx/sites-available/`;
# TODO - at this stage the below writeNginxConfig call should use /var/www/html and not redirect - THIS CODE NEEDS TO BE ADDED AND THEN YOU CAN UNCOMMENT THE BELOW LINE
#writeNginxConfig("/etc/nginx/sites-available/default", \@domains);
`/bin/ln -s /home/pi/SKAD/html/guarddog.secure /var/www/html`;
`/usr/sbin/service nginx start`;

# NOTE: This call will not return a response because nginx was stopped above. So the Web page will have to wait a short while and then poll to see if the nginx server is back up and running

# Old code:
# my %response = ( message => "$message" );
# print encode_json(\%response)."\n";

