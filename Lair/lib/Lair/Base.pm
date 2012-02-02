  package Lair::Base;
# *******************
use Lair::Ground;

use Badger::Class
    version => '0.01';

sub new
{
    my $self = shift;
    my $class = ref($self) || $self;
    $self = bless {},$class;
    $self->init(@_);
    $self->check();
    return $self;
}

sub init {}

sub check {}

1;

__END__

=head1 NAME

Lair::Base - the base for most of the Lair classes

=head1 SYNOPSIS

   use Badger::Class
      base => 'Lair::Base';

=head1 DESCRIPTION

A base class which does nothing more than blessing the object in the C<new>
constructor method.

=head2 Methods

=over 4

=item new

=item init - called by new with arguments

=item check - called by new without further arguments

=back


