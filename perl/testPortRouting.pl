#!/usr/bin/perl

use JSON;
use HTTPFunctions;
#use LWP::Simple;
use LWP::UserAgent;

my $parmsRef = HTTPFunctions->getQuerystringDictionary($ARGV[0]);
my %parms = %$parmsRef;
my $domain = $parms{domain};
my $port = $parms{port};

# Make a get request to this link
# http://$domain:$port/php/exec.php?script=portRoutingHandshake
#$contents = get("http://$domain:$port/php/exec.php?script=portRoutingHandshake");
#$contents = get("http://www.6n1s.com");
#print "contents=$contents\n";

my $ua = LWP::UserAgent->new;
my $server_endpoint = "http://$domain:$port/php/exec.php?script=portRoutingHandshake";
 
# set custom HTTP request header fields
my $req = HTTP::Request->new(GET => $server_endpoint);
#$req->header('content-type' => 'application/json');
#$req->header('x-auth-token' => 'kfksj48sdfj4jd9d');
 
my $resp = $ua->request($req);
if ($resp->is_success) {
    my $message = $resp->decoded_content;
    print "$message\n";
}
else {
    my %result;
    $result{success} = "false";
    $result{HTTPCode} = $resp->code;
    $result{HTTPMessage} = $resp->message;
   
    print encode_json(\%result)."\n";
}

