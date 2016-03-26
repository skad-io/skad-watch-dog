#!/usr/bin/perl

use Server;
use NginxConfigFunctions;
 
my @servers = readNginxConfig("/etc/nginx/sites-available/default");

foreach my $server (@servers) {
	print $server->toString()."\n";
}
