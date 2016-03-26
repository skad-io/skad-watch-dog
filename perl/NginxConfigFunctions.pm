#!/usr/bin/perl

use Server;
use strict;
use warnings;

sub writeNginxConfig {

	my $outputFilename = shift;
	my $serversRef = shift;
	my @servers = @$serversRef;

	open(my $fh, '>', $outputFilename);

	my $fullDomainList = "";

	foreach my $server (@servers) {

		my $port = $server->getPort();
		my $domains = $server->getDomains();
		my $targetAddress = $server->getTargetAddress();
		my $firstDomain = (split / /, $domains)[0];

		#TODO: Only add to domain list if not already in there
		$fullDomainList = $fullDomainList.$domains." ";

		print $fh "
server {
	listen $port ssl;

	server_name $domains;

        ssl_certificate /etc/letsencrypt/live/$firstDomain/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/$firstDomain/privkey.pem;

        ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
        ssl_prefer_server_ciphers on;
        ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';

	# TODO: I'm not sure root or index are needed with proxy_pass - but if this doesn't work then you now know why

        #root /var/www/html/clee.pro;

        # Add index.php to the list if you are using PHP
        #index index.html index.htm index.nginx-debian.html;

        location / {
                proxy_pass $targetAddress;
        }
}
";
		}

	print $fh "
server {
    listen 80;
    server_name $fullDomainList;
    return 301 https://\$host\$request_uri;
}
";
	close $fh;		
}


sub readNginxConfig {

	my $inputFilename = shift;
 
	open(FILE, '<', $inputFilename) or die "Could not open file: $inputFilename, $!";

	my @servers;

	my $port;
	my $domains;
	my $targetAddress;
	
	while (my $line = <FILE>) {
				
		#$line =~ m/server {/ and do {
		#	print "$line";						
		#}

		$line =~ m/listen (\d+)/ and do {
			$port = $1;
		};

		$line =~ m/server_name (.+);/ and do {
			$domains = $1;
		};

		$line =~ m/proxy_pass (.+);/ and do {
			$targetAddress = $1;

			# The redirection entry for port 80 will always be built from scratch when writing the config file so no need to pass it			
			if ($port != 80) {
				push @servers, new Server($port, $domains, $targetAddress);
			}
		};
	}

	return @servers;
}
1;
