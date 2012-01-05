  package Lair::Context;
# **********************
use Badger;

use Badger::Class
    version => '0.01',
    base => 'Plack::Request',
    import => 'class';


sub exception
{
    my ($self, $err) = @_;

    $err->{location} = $err->{location}->as_string
        if $err->{location} && ref $err->{location} =~ m/^URI/;

    $self->make_exception($err)->throw;
}

sub _exception_class
{
    my $class = 'Lair::Exception';
    class($class)->load;
    return $class;
}

sub make_exception
{
    my ($self,$err) = @_;
    $self->_exception_class->new($err);
}

1;

__END__

=head1 NAME

Lair::Context

=head1 AUTHORS

Ido Perlmuter - author of Leyland::Context

Sebastian Knapp - writes this file


