
use strict;
use warnings;

use Test::More tests => 5;

BEGIN {
    use_ok('Lair');
    use_ok('Lair::Context');
};

ok(Lair->can('new'),'Lair has the default constructor');
ok(Lair::Context->can('new'),'Lair::Context has the default constructor');

my $app = Lair->new();
isa_ok($app,'Lair');




