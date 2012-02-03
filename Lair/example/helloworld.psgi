#!/usr/bin/perl

use lib './lib';
use strict;
use warnings;

use Lair;
use Lair::Controller;
use Lair::Response::Redirect;

use Plack::Builder;

my $app = Lair->new('name' => 'hello world example app');
my $hellocontroller = Lair::Controller->new(prefix => '/hello');
my $redirectcontroller = Lair::Controller->new();

# /favicon.ico

my $greeting = Lair::Resource->new(
    regex => qr|^/hello/?(?<name>[\w\s]+)?$|,
    get => sub {
      return 'hello w';
    },
    returns => 'text/plain'
);

my $redirect = Lair::Response::Redirect->new(
    regex => qr|^/.*$|,
    to => '/hello'
);

$app->add_controller(
    $hellocontroller->add_resource($greeting),
    $redirectcontroller->add_resource(Lair::Resource->new)
);

builder { $app->handler };
