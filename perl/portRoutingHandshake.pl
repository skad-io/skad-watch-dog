#!/usr/bin/perl

use JSON;

# I think this will need to be done for both port 80 and port 443 (SSL) so set up a rule in nginx to route port 443 to port 80

my %result = ( success => "true" );

print encode_json(\%result)."\n";

