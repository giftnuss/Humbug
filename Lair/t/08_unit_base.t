
use strict;
use warnings;

use Test::More tests => 6;

BEGIN {
  use_ok('Lair::Base');
}

is(0+ @Lair::Base::ISA,0,'Lair::Base has no base class');
ok(Lair::Base->can('new'),'Lair::Base has "new" method.');
ok(Lair::Base->can('init'),'Lair::Base has "init" method.');
ok(Lair::Base->can('check'),'Lair::Base has "check" method.');

my $obj = Lair::Base->new;
isa_ok($obj->new,'Lair::Base','make test cover more happy');
