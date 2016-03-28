#!/usr/bin/perl

use JSON;
use HTTPFunctions;

my $externalIP = `/usr/bin/wget -qO- http://ipecho.net/plain`;
my $parmsRef = HTTPFunctions->getQuerystringDictionary($ARGV[0]);
my %parms = %$parmsRef;
my @domains = split / /, $parms{domains};
my @domainsArray;

foreach $domain (@domains) {
	my $domainAddress = `/usr/bin/host $domain`;

	$domainAddress =~ m/.+has address (.+)/ and do {
		my %domainHash;
		$domainHash{domain} = $domain;
		$domainHash{address} = $1;
		push @domainsArray, \%domainHash; 
	}
}

my %wifiListHash = ( externalIP => $externalIP, domains => \@domainsArray );
print encode_json(\%wifiListHash)."\n";

