  package Lair::Negotiator;
# *************************

use Badger;

use Badger::Class
    version => '0.01',
    base => 'Lair::Base',
    mixin => [
        'Lair::Mixin::Build',
        'Lair::Mixin::Destroy'
    ],
    accessors => [
        'app',
        'dispatcher'
    ];

sub _default_app {
    die("app is a required argument constructing a Lair::Negotiator");
}

sub _default_dispatcher {
    my ($self,$params) = @_;
    my $class = 'Lair::Dispatcher';
    class($class)->load;
    return $class->new($params);
}

sub negotiate {
    my ($self,$context) = @_;
    my $resource = $self->dispatcher->dispatch($context);
    if($resource->any) {
        $resource->action($resource->any);
    }
    else {
        my $method = lc($context->method);
        $resource->action($resource->$method);
    }
    return $resource;
}

1;

__END__

