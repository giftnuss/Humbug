
use strict;
use warnings;
use Test::More;

use Lair;
use Package::Subroutine;

my $class;
BEGIN {
  $class = 'Lair::Context';
  use_ok($class);
  isa_ok($class,'Plack::Request');
};

my %skip = (
    VERSION => 1
);
my %pr = map { $_ => 1 }
    grep { !exists($skip{$_}) }
    Package::Subroutine->findmethods('Plack::Request');

ok(!$class->can('app'),'Plain class can not app');

my $app = Lair->new();
ok($class->can('app'),'after creation of app - context can app');

foreach my $method (Package::Subroutine->findsubs($class)) {
    next if $skip{$method};
    ok(!exists($pr{$method}),"$method overwrites no method in base class");
}

my $env = {
    'psgi.url_scheme' => 'http',
    HTTP_HOST => 'example.com'
};

my $context = Lair::Context->new($env);

done_testing();
