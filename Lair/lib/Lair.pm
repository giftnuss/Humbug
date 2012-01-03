  package Lair;
# *************
use Badger;

use Badger::Class
    version => 0.01,
    mixin => [
        'Lair::Mixin::Build'
    ],
    accessors => [
        'config',
        'context_class', # context_builder ?
        'cwe',
        'localizer',
        'log',
        'name',
        'req_counter',
        'routes',
        'views'
    ];

sub _inc_req_counter
{
    $_[0]->{'req_counter'} ++
}

sub _build_context
{
    my ($self,$env) = @_;
    return $self->context_class->new(
        app => $self,
        env => $env,
        num => $self->req_counter
    );
}

sub setup { 1 }

sub handle
{
    my ($self, $env) = @_;
    $self->_inc_req_counter;
    my $c = $self->_build_context($env);

	# create the context object

	# does the request path have an "unnecessary" trailing slash?
	# if so, remove it and redirect to the resulting URI
	if ($c->path ne '/' && $c->path =~ m!/$!) {
		my $newpath = $`;
		my $uri = $c->uri;
		$uri->path($newpath);
		
		$c->res->redirect($uri, 301);
		return $c->_respond;
	}

	# is this an OPTIONS request?
	if ($c->method eq 'OPTIONS') {
		# get all available methods by using Leyland::Negotiator
		# and return a 204 No Content response
		$c->log->debug('Finding supported methods for requested path.');
		return $c->_respond(204, { 'Allow' => join(', ', Leyland::Negotiator->find_options($c, $self->routes)) });
	} else {
		# negotiate for routes and invoke the first matching route (if any).
		# handle route passes and return the final output after UTF-8 encoding.
		# if at any point an expception is raised, handle it.
		return try {
			# get routes
			$c->log->debug('Searching matching routes.');
			$c->_set_routes(Leyland::Negotiator->negotiate($c, $self->routes));

			# invoke first route
			$c->log->debug('Invoking first matching route.');
			my $ret = $c->_invoke_route;

			# are we passing to the next matching route?
			# to prevent infinite loops, limit passing to no more than 100 times
			while ($c->_pass_next && $c->current_route < 100) {
				# we need to pass to the next matching route.
				# first, let's erase the pass flag from the context
				# so we don't try to do this infinitely
				$c->_set_pass_next(0);
				# no let's invoke the route
				$ret = $c->_invoke_route;
			}

			$c->finalize(\$ret);
			
			$c->_respond(undef, undef, $ret);
		} catch {
			$self->_handle_exception($c, $_);
		};
	}
}

1;

__END__

=head1 NAME

Lair - wish it grows to be a useful web framework

=head2 DESCRIPTION

A try to port Layland from Moose to Badger
framework. This will be a friendly fork, only
with intention to see how far it goes.

