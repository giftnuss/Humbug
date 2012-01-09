
package main;
use Badger;

use Badger::Test tests => 8;

package The::Quality;

use Badger::Class
    base => 'Lair::Base',
    mixin => [ 'Lair::Mixin::Build' ],
    accessors => [ 'constraints' ],
    mutators => [ 'weight' ];

sub _default_weight { 0.5 }

sub _default_constraints { '' }

package main;

sub check_quality
{
    my ($quality,$weight,$constraints) = @_;

    is($quality->weight(),$weight);
    is($quality->constraints(),$constraints);
}

check_quality(The::Quality->new(), 0.5, '');
check_quality(The::Quality->new({weight => 1}),1,'');
check_quality(The::Quality->new(weight => 1),1,'');
check_quality(The::Quality->new(constraints => 'greater than zero'),
    0.5,'greater than zero');
