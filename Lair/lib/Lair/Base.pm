  package Lair::Base;
# *******************
use Badger;

use Badger::Class
    version => '0.01';

sub new
{
    my ($self) = shift;
    my $class = ref($self) || $self;
    $self = bless {},$class;
    $self->init(@_);
    return $self;
}

sub init {}

1;

