
use File::Basename;
use Plack::Builder;

my @libs;
BEGIN {
   my $humbug = dirname(dirname(__FILE__));
   push @libs ,
      "$humbug/rocklab/lib", 
      "$humbug/p5-rock-linux/lib", 
      "$humbug/Lair/lib";
};

use lib @libs;

use rocklab::application;

my $app = rocklab::application;

builder { $app->handler }
