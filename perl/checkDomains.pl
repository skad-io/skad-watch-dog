#!/usr/bin/perl

use JSON;
use HTTPFunctions;

my $externalIP = `/usr/bin/wget -qO- http://ipecho.net/plain`;
my $decodedParms = $ARGV[0] =~ s/%20/ /r; # This should really use a proper decode function
my $parmsRef = HTTPFunctions->getQuerystringDictionary($decodedParms);
my %parms = %$parmsRef;
my @domains = split / /, $parms{domains};
my %domainsHash;

foreach $domain (@domains) {
	my $domainAddress = `/usr/bin/host $domain`;

	$domainAddress =~ m/.+has address (.+)/ and do {
		$domainsHash{$domain} = $1;
	}
}

my %wifiListHash = ( externalIP => $externalIP, domains => \%domainsHash );
print encode_json(\%wifiListHash)."\n";

