#!/usr/bin/perl

use JSON;

my $wifiData = `/sbin/iwlist wlan0 scan`;
my @wifiDataArray = split /\n/, $wifiData;
my @wifiList;

foreach $line (@wifiDataArray) {

	$line =~ m/ESSID:"(.+)"/ and do {
		push @wifiList, $1;
	}
}

my %wifiListHash = ( wifiList => \@wifiList );
print encode_json \%wifiListHash;

