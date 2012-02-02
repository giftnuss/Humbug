  package Lair::Ground;
# *********************

use strict;
use warnings;
use utf8;
use 5.010001;
use feature ();

use Badger v0.08 ();

sub import {
  strict->import;
  warnings->import;
  utf8->import;
  feature->import(':5.10');
}

1;

