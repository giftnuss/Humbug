  package Lair::Mixin::Destroy;
# *****************************
use Lair::Ground;

use Badger::Class
    version => '0.01',
    mixins => [
        '_default_05_app',
        'DESTROY'
    ];

sub _default_05_app {
    die("app is a required argument constructing a Lair::Negotiator");
}

sub DESTROY {
    my ($self) = @_;
    $self->{'app'} = undef;
}

1;

__END__


