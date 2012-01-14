
use Test::More;

use Lair::Resource;

my $resource = Lair::Resource->new();

is(ref $resource,'Lair::Resource','object creation without arguments');

my @regex = (
  [Lair::Resource->_default_regex,[map {''}0..0]],
  [qr|/id/(?<id>\d+)|,[1]]
);

my @paths = (
  '/id/55'
);

foreach my $regex (@regex) {
    my $resource = Lair::Resource->new(regex => $regex->[0]);
    diag("checking " . $resource->regex);
    foreach my $idx (0..$#paths) {
        my $path = $paths[$idx];
        is($resource->match($path),$regex->[1][$idx],
            ($regex->[1][$idx] ? "" : "not ")."matching $path");
    }
}

use Data::Dumper;
done_testing();
