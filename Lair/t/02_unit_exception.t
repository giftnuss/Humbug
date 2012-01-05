
use strict;

use Test::More tests => 5;

BEGIN {
  use_ok('Lair::Context');
  use_ok('Lair::Exception');
};

my $error = Lair::Exception->new;

isa_ok($error,'Lair::Exception');
is($error->type,'http','type is http');
is($error->line,'unknown','detect the line');

# my $context = Lair::Context->new();
# $error = $context->make_exception();
# is($error->type,'http','type is http');
