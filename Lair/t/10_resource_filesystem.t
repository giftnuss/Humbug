
use strict;
use warnings;

use Test::More tests => 11;

BEGIN {
    use_ok('Lair::Resource::Filesystem');
}

my @checks = (
   ['' => []],
   ['/' => []],
   ['///' => []],
   ['/abc' => ['abc']],
   ['/def/ghi.jkl' => ['def','ghi.jkl']]
);

my $resource = Lair::Resource::Filesystem->new();

foreach my $chk (@checks) {
   ok($resource->match($chk->[0]),$chk->[0] . ' matches');
   $resource->if_matched($chk->[0]);
   my @expected = ($chk->[0],@{$chk->[1]});
   is_deeply($resource->matches,\@expected,'expected matches');
}

use Data::Dumper;