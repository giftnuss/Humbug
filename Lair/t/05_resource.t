
use strict;
use warnings;

use Test::More;

use Lair::Resource;

my $resource = Lair::Resource->new();

is(ref $resource,'Lair::Resource','object creation without arguments');

my @regex = (
  [Lair::Resource->_default_regex,(map {''}0..0)],
  [qr|/id/(?<id>\d+)|,[{id => 55},[55]]]
);

my @paths = (
  '/id/55'
);

foreach my $regex (@regex) {
    my $resource = Lair::Resource->new(regex => $regex->[0]);
    diag("checking " . $resource->regex);
    foreach my $idx (0..$#paths) {
        my $path = $paths[$idx];
        my $expect = $regex->[$idx+1];
        if($expect) {
            my $vars = $expect->[0];
            my @matches = ($path,@{$expect->[1]});
            ok($resource->match($path),"matching $path");
            is_deeply($resource->vars,$vars,'expected vars');
            is_deeply($resource->matches,\@matches,'expected matches');
        }
        else {
            ok(!$resource->match($path),'regex not matching path');
        }
    }
}

use Data::Dumper;
done_testing();
