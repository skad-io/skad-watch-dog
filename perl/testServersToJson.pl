#!/usr/bin/perl

#use JSON;
use Server;
use ServerFunctions;
 
my @servers;

push @servers, new Server(10001, "clee.pro www.clee.pro", "http://192.168.0.104:10001");
push @servers, new Server(10002, "clee.pro www.clee.pro", "http://192.168.0.104:10002");
push @servers, new Server(10003, "clee.pro www.clee.pro", "http://192.168.0.104:10003");

#TODO Replace this with a static method call to the Server class (once I figure out how to do that)
my $result = ServerFunctions->serversToJson(@servers);

print "\%result = $result\n";

# Working list encode example

#print "###############\n";
#my %list1 = ( a => 1, b => 2 );
#my $json1 = encode_json (\%list1);
#print "\$json1 = $json1\n";

