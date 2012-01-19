
use strict;
use Test::More tests => 27;

use Lair;

my $class;
BEGIN {
  $class = 'Lair::Context';
  use_ok($class);
};

my @pr = (
    'env',
    'address',
    'remote_host',
    'protocol',
    'method',
    'port',
    'user',
    'request_uri',
    'path_info',
    'path',
    'script_name',
    'scheme',
    'secure',
    'body',
    'input',
    'content_length',
    'content_type',
    'session',
    'session_options',
    'logger',
    'cookies',
    'query_parameters',
    'content',
    'raw_body'
);

ok($class->can($_),"$class can $_ (Plack::Request)") for @pr;

ok(!$class->can('app'),'Plain class can not app');

my $app = Lair->new();
ok($class->can('app'),'after creation of app - context can app');

my $env = {
    'psgi.url_scheme' => 'http',
    HTTP_HOST => 'example.com'
};

my $context = Lair::Context->new($env);