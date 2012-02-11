  package Lair::Context;
# **********************
use Lair::Ground;
use Class::Trigger;

use Badger::Class
    version => '0.02',
    base => 'Plack::Request',
    mixin => [
        'Lair::Mixin::Breaks'
    ];

1;

__END__

=head1 NAME

Lair::Context

=head1 DESCRIPTION

This is a subclass of Plack::Request.

=head2 Methods Breaking The Flow

=over 4

=item redirect

=item error

=back

=head1 AUTHORS

Sebastian Knapp - writes this file


