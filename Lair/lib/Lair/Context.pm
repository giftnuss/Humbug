  package Lair::Context;
# **********************
use Lair::Ground;

use MIME::Types;
use Plack::Response;

use Badger::Class
    version => '0.01',
    base => 'Plack::Request',
    import => 'class';

sub respond_resource {
    my ($self,$resource) = @_;
    my $response = $self->_build_res;
    $response->content_type($resource->returns);
    $response->body($resource->action->($self));
    return $response;
}

sub respond_error {
    my ($self,$error) = @_;
    my $response = $self->_build_res($error->code);
    $response->content_type('text/plain');
    $response->body($error->name);
    return $response;
}

sub _build_res {
    my ($self,$code) = (@_,200);
    my $response = Plack::Response->new($code); 
    $response->header('X-Framework' => 'Lair v'.$Lair::VERSION);
    return $response;
}

# --- ist nich so doll

sub error
{
    my ($self,$code) = (@_,500);
    $self->make_exception({code => $code});
}

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


