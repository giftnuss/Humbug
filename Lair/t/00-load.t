
use strict;
use warnings;

use Test::More tests => 11;

BEGIN {
    use_ok('Lair');
    use_ok('Lair::Context');
    use_ok('Lair::Hub');
};

ok(Lair->can('new'),'Lair has the default constructor');
ok(Lair::Context->can('new'),'Lair::Context has the default constructor');

my $app = Lair->new();
isa_ok($app,'Lair');

is($app->cwe,'development','default cwe');
is($app->name,'lair','default name');

ok($app->can('localizer'),'access localizer object');
ok($app->can('loc'),'delegates "loc" to localizer');

isa_ok($app->localizer,'Lair::Localizer','default localizer class');
