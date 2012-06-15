  package Lair::Responder;
# ************************
use Lair::Ground;

use HTTP::Status;
use Plack::Response;

use Badger::Class
    base => 'Lair::Base',
    version => '0.01',
    mixin => [
        'Lair::Mixin::Build',
        'Lair::Mixin::App'
    ];

sub resource {
    my ($self,$resource) = @_;
    my $response = $self->_build_response($resource->code);
    $response->content_type($resource->returns);
    $response->body($resource->action->($resource,$response));
    return $response;
}

sub exception {
    my ($self,$error) = @_;
    my $response = $self->_build_response($error->code);
    unless(HTTP::Status::is_redirect($error->code)) {
        $response->content_type($error->returns);
    }
    $response->body($error->action->($error,$response));
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

=head1 NAME

Lair::Responder - Utility for turning a resource into a response

=head1 SYNOPSIS

