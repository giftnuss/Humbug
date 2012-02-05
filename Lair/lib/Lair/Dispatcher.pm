  package Lair::Dispatcher;
# *************************

use Lair::Ground;

use Badger::Class
    version => '0.01',
    base => 'Lair::Base',
    mixin => [
        'Lair::Mixin::Build',
	'Lair::Mixin::App',
    ];

sub dispatch {
    my ($self,$context) = @_;
    my $path = $context->path_info;
    my @controllers =
        map { $self->app->controllers->get_all($_) }
        sort { length($b) <=> length($a) }
        grep { substr($path,0,length($_)) eq $_ }
        keys %{$self->app->controllers};

    for my $controller (@controllers) {
        my $short = $controller->prefix eq '/' ? $path :
            substr($path,length($controller->prefix));
        for my $resource (@{$controller->resources}) {
            if($resource->match($path)) {
                $resource->context($context);
                $resource->controller($controller);
                return $resource;
            }
        }
    }
    $context->error(404);
}

use Data::Dumper;

1;

__END__

