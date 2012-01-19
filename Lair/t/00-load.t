
use strict;
use warnings;

use Test::More tests => 18;

use Cwd ();

BEGIN {
    use_ok('Lair');
    use_ok('Lair::Context');
    use_ok('Lair::Hub');
};

ok(Lair->can('new'),'Lair has the default constructor');
ok(Lair::Context->can('new'),'Lair::Context has the default constructor');
ok(Lair::Context->can('error'),'Lair::Context has error method');

my $app = Lair->new();
isa_ok($app,'Lair');

is($app->cwe,'development','default cwe');
is($app->home->path, Cwd::getcwd, 'default home is current working directory');
is($app->name,'lair','default name');

ok($app->can('localizer'),'access localizer object');
ok($app->can('loc'),'delegates "loc" to localizer');

isa_ok($app->localizer,'Lair::Localizer','default localizer class');

ok($app->can('negotiator'),'app has an negotiator accessor');
my $negotiator = $app->negotiator;
isa_ok($negotiator,'Lair::Negotiator','default negotiator class');
is_deeply($negotiator->app,$app,'negotiator contains app object');
my $dispatcher = $negotiator->dispatcher;
isa_ok($dispatcher,'Lair::Dispatcher','default dispatcher class');
is_deeply($dispatcher->app,$app,'dispatcher contains app object');
