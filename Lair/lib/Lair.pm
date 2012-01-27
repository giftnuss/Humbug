  package Lair;
# *************
use 5.010001;
use Badger v0.08;

use Cwd ();
use Badger::Filesystem qw/Dir/;
use Hash::MultiValue;
use Package::Subroutine;
use Try::Tiny;

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
    my ($app) = @_;
    no warnings 'redefine';
    class($app->context_class)->load;
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
    my $context = $self->_build_context($env);

    my $response = try {
        my $resource = $self->negotiator->negotiate($context);
        return $context->respond_resource($resource);
    }
    catch {
        if(blessed($_) and $_->isa('Lair::Exception')) {
            return $context->respond_error($_);
        }
        else {
            return $context->respond_error($context->error(500));
        }
    };
    $response->finalize;
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

Package::Subroutine->remove('_' => ('Dir','catch','try','finally','class'));

1;

__END__

=head1 NAME

Lair - wish it grows to be a useful web framework

=head1 DESCRIPTION

This project started with the idea to build a small web framework with
the help of a Badger. Because I like the Leyland framework some ideas
and small portions of code are borrowed from it.

=head2 Read Only Accessors

=over 4

=item context_class

The class used for creation of the context object.

=item cwe

A plain string with the current working environment.
'development' is used as default value.

=item home

A Badger::Filesystem::Directory object. The default
is the current working directory.

=item controllers

A Hash::MultiValue object. C<$controller->prefix> is used as
key and the controller object is one of the values.

=item hub

This is a thing from Badger helping delegate to other objects.

=back

=head1 AUTHORS

Ido Perlmuter - Author of the original Leyland.pm code

Sebastian Knapp - writes this file
