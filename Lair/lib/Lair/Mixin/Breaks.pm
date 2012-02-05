  package Lair::Mixin::Breaks;
# ****************************
use Lair::Ground;

use Lair::Response::Error;
use Lair::Response::Redirect;

use Badger::Class
    version => '0.01',
    mixins => [
        'error',
        'redirect'
    ];

sub redirect {

}

sub error {
  my ($self,$code,$description) = (@_,'');
  my $error = Lair::Response::Error->new(
      code => $code,
      description => $description,
      context => $self
  );
  die($error);
}

1;

__END__