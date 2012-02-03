  package Lair::Mixin::App;
# *************************
use Lair::Ground;

use Badger::Class
    version => '0.01',
    mixins => [
        'app',
        '_default_05_app',
        'DESTROY'
    ],
    'accessors' => [
        'app'
    ];

sub _default_05_app {
    die("app is a required argument constructing a " . ref($_[0]));
}

sub DESTROY {
    my ($self) = @_;
    $self->{'app'} = undef;
}

1;

__END__


