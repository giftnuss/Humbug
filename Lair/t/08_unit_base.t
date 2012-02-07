
use strict;
use warnings;

use Test::More tests => 5;

BEGIN {
  use_ok('Lair::Base');
}

is(0+ @Lair::Base::ISA,0,'Lair::Base has no base class');
ok(Lair::Base->can('new'),'Lair::Base has "new" method.');
ok(Lair::Base->can('init'),'Lair::Base has "init" method.');

my $obj = new Lair::Base;
isa_ok($obj->new,'Lair::Base','make test cover more happy');
