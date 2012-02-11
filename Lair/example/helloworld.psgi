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

my $favicon = pack("H*",join('',
"0000010001002020100001000400e80200001600000028000000200000004000000001000400000",
"00000000000000000000000000000000000000000000005090700191b1a00292c2a00383a380048",
"4b490056595700696c6a007a7d7b008b8e8c00a0a3a100afb2b000c3c6c400d7dbd800e4e8e600f",
"cfffd0000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee",
"eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeb",
"ceeeeeeeeeeeeeeeeeeeeeeeb9eeeeeaceeeeeeeeeeeeeeeeeeeeeeedceeeeeeeeeee8beeeeeeee",
"eeeeeeeeeeeeb543deeeeeeeeeeeeeeeeeeecceeeeec17a5367ee659eeeeeeeeeeeeabeee8355ee",
"8582945932ceecdeeeeeeeeee72836eeeeea06eee91ee9beeeeeeeeea1ceeeeeeeed1ceee64eeee",
"eeeeeeeee4beeeeeeeeeeceed32deeeeeeeeeeeee3ceeeeeeeeeeeee35eeeeeeeeeeebeee81aeee",
"eeeeeeeee2beeeeeeeeeed9eeeea18eeeeeeeeeee3ceeeeec8eeeeeeeeeed26eed89ceeed2eeeee",
"eeeeeeeeeeeeeee223145245674eeeeeeeeeeeeeeeeeeed29bcedba8819eeeeeeceeeeeeeeeeeea",
"4eed221aee68eeeeee8ceeee8ceeeee85eeeddecee94eeeeeeeeeeeedeeeeee67ea5cea23ee2cee",
"eeeeeeeeeeeeeeee3be163a2c3ae2beeeeeeeeeeeeeeeeee3ce393a3b78b2eeeec8eeeeeeeeeeee",
"e56ec26ec23968eeeeedeeeeeeeeeddeed23beeee8023deeeeeeeeeeeeeeeaaeeee91585148aeee",
"eeeeeeeeeeeeeeeeeeeeed648deeeeaceeeeeeeeeeeeeeeeeeeeeeeeeeeeeebceeeeeeeeeeeeeee",
"eeee8eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeebeeee8ceeeeeeeeeeeeeeeeeeeeeeeeeeeeeedeeeee",
"eeeeeeeeeeee0000000000000000000000000000000000000000000000000000000000000000000",
"0000000000000000000000000000000000000000000000000000000000000000000000000000000",
"0000000000000000000000000000000000000000000000000000000000000000000000000000000",
"0000000000000000000000000000000"));

my $faviconcontroller = Lair::Controller->new(
    prefix => '/favicon.ico',
    resources => [
        Lair::Resource->new(regex => qr||, get => sub { $favicon },
             returns => 'image/x-icon')  
    ]);

my $greeting = Lair::Resource->new(
    regex => qr|^/(?<name>[\w\s]+)?$|,
    get => sub {
      my ($self,$response) = @_;
      my $name = ($self->vars->{'name'} || 'world');
      return "Hello $name!";
    },
    returns => 'text/plain'
);

my $redirect = Lair::Response::Redirect->new(
    location => '/hello/'
);

$app->add_controller(
    $hellocontroller->add_resource($greeting),
    $redirectcontroller->add_resource($redirect),
    $faviconcontroller
);

builder { $app->handler };
