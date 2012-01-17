  package Lair::Negotiator;
# *************************

use Badger;

use Badger::Class
    version => '0.01',
    base => 'Lair::Base',
    mixin => [
        'Lair::Mixin::Build'
    ],
    accessors => [
        'app',
        'dispatcher'
    ];

sub _default_app {
    die("app is a required argument constructing a Lair::Negotiator");
}

sub _default_dispatcher {
    my $class = 'Lair::Dispatcher';
    class($class)->load;
}

1;

__END__

