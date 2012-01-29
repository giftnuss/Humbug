package Lair::Resource::Filesystem;
# *********************************

use Badger;

use Badger::Class
    version => '0.01',
    base => 'Lair::Resource';

sub _default_regex {
    qr|^(?:/([^/]*))*$|
}

__PACKAGE__->add_trigger('if_matched',sub {
    my ($self,$path) = @_;
    $self->{'matches'} = [$path,grep { length } split('/',$path)];
});

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


