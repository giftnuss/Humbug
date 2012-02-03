  package Lair::Negotiator;
# *************************

use Lair::Ground;

use Badger::Class
    version => '0.01',
    base => 'Lair::Base',
    mixin => [
        'Lair::Mixin::Build',
        'Lair::Mixin::App'
    ],
    accessors => [
        'dispatcher'
    ];

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

