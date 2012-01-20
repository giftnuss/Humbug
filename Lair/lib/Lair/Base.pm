  package Lair::Base;
# *******************
use Badger;

use Badger::Class
    version => '0.01';

sub new
{
    my $self = shift;
    my $class = ref($self) || $self;
    $self = bless {},$class;
    $self->init(@_);
    return $self;
}

sub init {}

1;

__END__

=head1 NAME

Lair::Base - the base for most of the Lair classes

=head1 SYNOPSIS

   use Badger::Class
      base => 'Lair::Base';

=head1 DESCRIPTION

A base class which does nothin more than blessing the object in the C<new>
constructor method.

=head2 Methods

=over 4

=item new

=item init

=back


