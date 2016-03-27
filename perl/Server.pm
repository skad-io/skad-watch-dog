#!/usr/bin/perl 

package Server;

sub new
{
    my $class = shift;
    my $self = {
        _port          => shift,
        _domains       => shift,
        _targetAddress => shift,
    };

    bless $self, $class;
    return $self;
}

sub setPort {
    my ( $self, $port ) = @_;
    $self->{_port} = $port if defined($port);
    return $self->{_port};
}

sub getPort {
    my( $self ) = @_;
    return $self->{_port};
}

sub setDomains {
    my ( $self, $domains ) = @_;
    $self->{_domains} = $domains if defined($domains);
    return $self->{_domains};
}

sub getDomains {
    my( $self ) = @_;
    return $self->{_domains};
}

sub setTargetAddress {
    my ( $self, $targetAddress ) = @_;
    $self->{_targetAddress} = $targetAddress if defined($targetAddress);
    return $self->{_targetAddress};
}

sub getTargetAddress {
    my( $self ) = @_;
    return $self->{_targetAddress};
}

sub toString {
    my( $self ) = @_;
    return $self->getPort().",".$self->getDomains().",".$self->getTargetAddress();
}

1;
