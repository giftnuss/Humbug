  package Lair::Responder;
# ************************

use Lair::Ground;

use Badger::Class
    base => 'Lair::Base',
    version => '0.01',
    mixin => [
        'Lair::Mixin::Build',
        'Lair::Mixin::App'
    ];

sub resource {
    my ($self,$resource) = @_;
    my $response = $self->_build_response;
    $response->content_type($resource->returns);
    $response->body($resource->action->($self));
    return $response;
}

sub error {
    my ($self,$error) = @_;
    my $response = $self->_build_response($error->code);
    $response->content_type('text/plain');
    $response->body($error->name);
    return $response;
}

sub _build_response {
    my ($self,$code) = (@_,200);
    my $response = Plack::Response->new($code); 
    $response->header('X-Framework' => 'Lair v'.$Lair::VERSION);
    return $response;
}

1;

__END__

