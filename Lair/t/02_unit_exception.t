
use strict;

use Test::More tests => 8;

use HTTP::Request;
use HTTP::Message::PSGI;

BEGIN {
  use_ok('Lair::Context');
  use_ok('Lair::Exception');
};

my $error = Lair::Exception->new;

isa_ok($error,'Lair::Exception');
is($error->type,'http','type is http');
is($error->line,'unknown','unknown line');
is($error->code,500,'default code is 500');
is($error->name,'Internal Server Error','default name');

my $req = HTTP::Request->new( GET => 'http://localhost/' );

my $context = Lair::Context->new($req->to_psgi);
$error = $context->error(500);
is($error->type,'http','type is http');
