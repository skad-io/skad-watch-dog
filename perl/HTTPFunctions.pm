#!/usr/bin/perl 

package HTTPFunctions;

sub getQuerystringDictionary {
    my ( $self, $querystring ) = @_;
    my $decodedParms = $querystring =~ s/%20/ /r; # This should really use a proper decode function
    my @pairs = split(/&/,$decodedParms);
    my %parms;
    my $item;
    my $value;

    # Store the item/value pairs in a hash
    foreach (@pairs)
    {
        my ($item,$value) = split(/=/,$_);
        $parms{$item} = $value;
    }

    return \%parms;
}

1;

