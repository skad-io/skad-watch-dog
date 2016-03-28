#!/usr/bin/perl

use JSON;
use HTTPFunctions;

my $externalIP = `/usr/bin/wget -qO- http://ipecho.net/plain`;
my $decodedParms = $ARGV[0] =~ s/%20/ /r; # This should really use a proper decode function
my $parmsRef = HTTPFunctions->getQuerystringDictionary($decodedParms);
my %parms = %$parmsRef;
my @domains = split / /, $parms{domains};
my @domainsArray;

foreach $domain (@domains) {
	my $domainAddress = `/usr/bin/host $domain`;

	$domainAddress =~ m/.+has address (.+)/ and do {
		my %domainHash = ( $domain => $1 );
		push @domainsArray, \%domainHash; 
	}
}

my %wifiListHash = ( externalIP => $externalIP, domains => \@domainsArray );
print encode_json(\%wifiListHash)."\n";

