#!/usr/bin/perl 

package HTTPFunctions;

sub getQuerystringDictionary {
    my ( $self, $querystring ) = @_;
    my @pairs = split(/&/,$querystring);
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

