  package Lair::Mixin::Build;
# ***************************
use Lair::Ground;
use Package::Subroutine;

use Badger::Class
    version => '0.01',
    mixins => ['init','class'],
    import => ['class'],
    utils => ['params'];

sub init
{
    my $self = shift;
    my $params = params(@_);
    BUILD($self,$params);
}

sub BUILD
{
    my ($self,$params) = @_;
    my $class = $self->class;
    my @defaults =
        sort { $a->[0] <=> $b->[0] }
        map {
              /^_default_?(\d*)_(\w+)$/;
              defined($2) ? [($1 || 50), $2, $_] : ()
        } Package::Subroutine->findmethods($class);

    foreach my $key (@defaults) {
	my $acc = $key->[1]; 
        if(exists($params->{$acc})) {
            $self->{$acc} = $params->{$acc};
            next;
        }
        my $method = $key->[2];
        $self->{$acc} = $self->$method($params);
    }
    return $self;
}

1;

__END__


