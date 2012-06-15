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

=head1 NAME

Lair::Ground - initializer for the lexical scope of a Lair file

=head1 SYNOPSIS

   use Lair::Ground;

=head1 DESCRIPTION

This modules imports the pragmas C<strict>, C<warnings>, C<utf8>
and the features of perl 5.10.

Also it requires Badger in the version 0.08.

=head1 UNWRITTEN

=over 4

=item unimport

=back


