  package Lair;
# *************
use 5.010001;
use Badger v0.08;

use Cwd ();
use Badger::Filesystem qw/Dir/;
use Hash::MultiValue;
use Package::Subroutine;

use Badger::Class
    version => 0.01,
    base => 'Lair::Base',
    mixin => [
        'Lair::Mixin::Build'
    ],
    accessors => [
        'config',
        'context_class', # context_builder ?
        'controllers',   # a Hash::MultiValue
        'cwe',           # development/production/...
        'home',
        'hub',
        'name',
        'negotiator',
        'req_counter',
        'routes',
        'views'
    ],
    auto_can => '_dynamic_subs';

sub _default_context_class { 'Lair::Context' }

sub _default_controllers { Hash::MultiValue->new() }

sub _default_cwe { 'development' }

sub _default_home { Dir( Cwd::getcwd ) }

sub _default_name { 'lair' }

sub _default_req_counter { 0 }

sub _default_hub
{
    my $class = 'Lair::Hub';
    class($class)->load;
    return $class->new
}

sub _default_negotiator
{
    my ($self) = @_;
    my $class = 'Lair::Negotiator';
    class($class)->load;
    return $class->new(app => $self);
}

sub _default_99_setup
{
    my ($self,$params) = @_;
    $self->setup_context($params);
    $self->setup($params);
}

sub setup_context
{
    my ($app,$params) = @_;
    no warnings 'redefine';
    Package::Subroutine->install($app->context_class, 'app', sub { $app });
}

sub setup { 'done' }

sub _inc_req_counter
{
    $_[0]->{'req_counter'} ++
}

sub _build_context
{
    my ($self,$env) = @_;
    return $self->context_class->new($env);
    #    app => $self,
    #    env => $env,
    #    num => $self->req_counter
    #);
}

sub add_controller
{
    my ($self,@controllers) = @_;
    foreach my $controller (@controllers) {
        $self->controllers->add($controller->prefix,$controller);
    }
}

sub handler
{
    my $app = shift;
    return sub {
	$app->handle(shift);
    };
}

sub handle
{
    my ($self, $env) = @_;
    $self->_inc_req_counter;
    my $c = $self->_build_context($env);

    # does the request path have an "unnecessary" trailing slash?
    # if so, remove it and redirect to the resulting URI
    if ($c->path ne '/' && $c->path =~ m!/$!) {
        my $newpath = $`;
        my $uri = $c->uri;
         $uri->path($newpath);
        $c->res->redirect($uri, 301);
        return $c->_respond;
    }
}

sub _dynamic_subs
{
    my ($self,$name) = @_;
    if(my $component = $self->hub->component($name)) {
        my $comp = $self->hub->$name();
        return sub { $comp }
    }
    if(my $delegate = $self->hub->delegate($name)) {
        my $comp = $self->hub->$delegate();
        my $method = $comp->can($name);
        return sub { $comp->$method(@_) }
    }
}

sub error_msg
{
    die($_[1]);
}

1;

__END__

=head1 NAME

Lair - wish it grows to be a useful web framework

=head1 DESCRIPTION

A try to port Layland from Moose to Badger
framework. This will be a friendly fork, only
with intention to see how far it goes.

=head2 Accessors

=over 4

=item context_class

The class used for creation of the context object.

=item cwe

A plain string with the current working environment.

'development' is used as default value.

=item home

A Badger::Filesystem::Directory object. The default
is the current working directory.

=back

=head1 AUTHORS

Ido Perlmuter - Author of the original Leyland.pm code

Sebastian Knapp - writes this file
