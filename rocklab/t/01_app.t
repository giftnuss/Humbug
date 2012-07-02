
use strict;
use warnings;

use Test::More;
use File::Spec;
use File::Basename;

BEGIN {
  use_ok("rocklab::application");
}

my $app = rocklab::application->new;

isa_ok($app,'rocklab::application');

is($app->context_class,'Lair::Context');
is($app->cwe,'development');

my $home = File::Spec->rel2abs(__FILE__);
$home = dirname($home) for 1..2;
is("".$app->home,$home,"home=$home");

done_testing();

