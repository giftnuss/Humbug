
use strict;
use warnings;

use Test::More tests => 1;

use Plack::Builder;
use Plack::Test;

BEGIN {
    use_ok('Lair::Response::Redirect');
}