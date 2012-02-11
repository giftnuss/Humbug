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
  my ($self,$to,$code) = (@_,302);
  die Lair::Response::Redirect->new(
      code => $code,
      location => $to,
      context => $self
  );
}

sub error {
  my ($self,$code,$description) = (@_,'');
  die Lair::Response::Error->new(
      code => $code,
      description => $description,
      context => $self
  );
}

1;

__END__
