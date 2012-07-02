package rocklab::application;

use File::Spec ();
use File::Basename ();

BEGIN {
  my $humbug = File::Spec->rel2abs(__FILE__);
  $humbug = File::Basename::dirname($humbug) for 1..4;

  eval "require Lair"; push @INC, "$humbug/Lair/lib" if $@;
  eval "require ROCK::Linux"; push @INC, "$humbug/p5-rock-linux/lib" if $@;
};

use Lair::Ground;

use Badger::Class
    base => 'Lair';

sub _default_home {
  my $rocklab = File::Spec->rel2abs(__FILE__);
  $rocklab = File::Basename::dirname($rocklab) for 1..3;
  Badger::Filesystem::Dir( $rocklab )
}

1;


