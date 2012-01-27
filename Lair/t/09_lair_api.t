
use strict;
use warnings;

use Test::More tests => 1;

use Lair;
use Package::Subroutine;

my @methods = qw/
    AUTOLOAD
    DOES
    VERSION
    _build_context
    _default_99_setup
    _default_context_class
    _default_controllers
    _default_cwe
    _default_home
    _default_hub
    _default_name
    _default_negotiator
    _default_req_counter
    _dynamic_subs
    _inc_req_counter
    add_controller
    can
    config
    context_class
    controllers
    cwe
    error_msg
    handle
    handler
    home
    hub
    init
    isa
    name
    negotiator
    new
    req_counter
    setup
    setup_context
    views/;

is_deeply([sort Package::Subroutine->findmethods('Lair')],\@methods,
    'predefined methods in package Lair');
