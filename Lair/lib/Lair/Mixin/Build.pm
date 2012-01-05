  package Lair::Mixin::Build;
# ***************************
use Badger;
use Package::Subroutine;

use Badger::Class
    version => '0.01',
    mixins => ['new','class'],
    import => ['class'],
    utils => ['params'];

sub new
{
    my $class = shift;
    my $params = params(@_);
    $class = ref($class) if ref($class);
    my $self = bless {}, $class;
    BUILD($self,$params);
}
use Data::Dumper;
sub BUILD
{
    my ($self,$params) = @_;
    my $class = $self->class;

    my @defaults = grep { defined }
        map {
              /^_default_(\w+)$/ ? $1 : () 
        } Package::Subroutine->findsubs($class);

    foreach my $key (@defaults) {
        if(exists($params->{$key})) {
            $self->{$key} = $params->{$key};
            next;
        }
        my $method = "_default_$key";
        $self->{$key} = $self->$method($params);
    }

    return $self;
}

1;

__END__


