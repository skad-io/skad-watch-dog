#!/usr/bin/perl 

package ServerFunctions;

use Server;
use JSON;
 
sub serversToJson {
    my ( $self, @servers ) = @_;
    my @serversArray = ();
    #my %result = { servers => [] };
        
    foreach $server (@servers) {
        
        my %serverHash = (
            port => $server->getPort(),
            domains => $server->getDomains(),
            targetAddress => $server->getTargetAddress(),
        );
           
        push @serversArray, \%serverHash;
    }
    
    my %serversHash = ( servers => \@serversArray );
    return encode_json \%serversHash;
}

1;

# Good has example for use with Json
#my $student = {
#    name => 'Foo Bar',
#    email => 'foo@bar.com',
#    gender => undef,
#    classes => [
#        'Chemistry',
#        'Math',
#        'Literature',
#    ],
#    address => {
#        city => 'Fooville',
#        planet => 'Earth',
#    },
#};    

