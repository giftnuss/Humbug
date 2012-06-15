  package Lair;
# *************
use Lair::Ground;

use Cwd ();
use Badger::Filesystem ();
use Try::Tiny ();

use Hash::MultiValue;
use Package::Subroutine;
use Plack::Response;

use Badger::Class
    version => 0.01,
    base => 'Lair::Base',
    import => 'class',
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
        'respond',
        'views'
    ],
    auto_can => '_dynamic_subs';

sub _default_context_class { 'Lair::Context' }

sub _default_controllers { Hash::MultiValue->new() }

sub _default_cwe { 'development' }

sub _default_home { Badger::Filesystem::Dir( Cwd::getcwd ) }

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

sub _default_respond
{
    my ($self) = @_;
    my $class = 'Lair::Responder';
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
    return $self;
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

    my $response = 
         Try::Tiny::try
         {
             my $resource = $self->negotiator->negotiate($context);
             return $self->respond->resource($resource);
         }
         Try::Tiny::catch
         {
             if(Scalar::Util::blessed($_) and $_->can('code')) {
                 return $self->respond->exception($_);
             }
             else {
	         return Plack::Response->new(500);
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

1;

__END__

=head1 NAME

Lair - wish it becomes a useful web framework

=head1 SYNOPSIS

    use Lair;
    use Lair::Controller;
    use Plack::Builder;
    use Time::localtime;
    
    my $app = Lair->new('name' => 'web watch');
    $app->add_controller(Lair::Controller->new(
    	prefix => '/',
        resources => [
            Lair::Resource->new(
            	regex => qr||, 
            	get => sub { my $tm = localtime; return sprintf("%d-%02d-%02d %02d:%02d:%02d",
            	    $tm->year+1900,$tm->month+1,$tm->mday,
            	    $tm->hour,$tm->min,$tm->sec) },
                returns => 'text/plain')
    ]);
    
    builder { $app->handler };

=head1 DESCRIPTION

This project started with the idea to build a small web framework with
the help of a Badger and Plack. Because I like the Leyland framework some ideas
and small portions of code are borrowed from it.

=head2 Class Description

This class is the basic application object. It is not very flexible because
a plack web application can hold different application. So the scope for this 
class is not too broad.

This class extends C<Lair::Base>.

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

A Hash::MultiValue object. C<$controller-E<gt>prefix> is used as
key and the controller objects are the values.

=item hub

This is a thing from Badger helping delegate to other objects.

=item negotiator

=item respond

Usualy this accessor contains a C<Lair::Responder> object. This
is not the response object itself, but an object responsible for
building them from resource or exception.

=back

=head1 AUTHOR

Sebastian Knapp writes this file

=head1 ACKNOWLEDGEMENT

Ido Perlmuter - Author of the original Leyland.pm code
 


