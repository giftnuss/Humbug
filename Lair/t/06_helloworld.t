use strict;
use warnings;

use Test::More tests => 1;

use Plack::Test;
use HTTP::Request::Common;

use Lair;
use Lair::Controller;

my $app = Lair->new('name' => 'hello world example app');
my $controller = Lair::Controller->new();

$controller->create_resource(qr|/auto|,
    get => sub { "Hello there!" },
    returns => 'text/plain'
);

$app->add_controller($controller);

{
    test_psgi $app->handler, sub {
        my $cb = shift;
        my $res = $cb->(GET '/auto');
        is $res->content, "Hello there!", "Hello world!";
    };
}

