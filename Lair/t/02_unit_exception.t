
use strict;
use warnings;

use Test::More tests => 8;
use Try::Tiny;
use Data::Dumper;

BEGIN {
  use_ok('Lair::Context');
};


my $env = {
    'psgi.url_scheme' => 'http',
    HTTP_HOST => 'example.com'
};

my $context = Lair::Context->new($env);
my $error = try { $context->error(500) } catch { return $_ };

print Dumper($error);
