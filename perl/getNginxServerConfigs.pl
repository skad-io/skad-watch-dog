#!/usr/bin/perl

use Server;
use ServerFunctions;
use NginxConfigFunctions;
 
my @servers = readNginxConfig("/etc/nginx/sites-available/default");

print ServerFunctions->serversToJson(@servers);

