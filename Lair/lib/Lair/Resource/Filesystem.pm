package Lair::Resource::Filesystem;
# *********************************
use Lair::Ground;

use Badger::Class
    version => '0.01',
    base => 'Lair::Resource';

sub _default_regex {
    qr|^(?:/([^/]*))*$|
}

sub if_matched {
    my ($self,$chunk) = @_;
    $self->{'matches'} = [$chunk,grep { length } split('/',$chunk)];
}

1;

__END__

=head1 NAME

Lair::Resource::Filesystem

=head1 DESCRIPTION

Some notes:

=over 4

=item

The default regex matches nearly everything. Thatswhy it does not make
much sense to have other resources in the same controller.

=back


