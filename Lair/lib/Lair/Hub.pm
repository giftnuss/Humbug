  package Lair::Hub;
# ******************
use Lair::Ground;

use Badger::Class
    version => '0.01',
    base => 'Badger::Hub::Badger';

our $COMPONENTS = {
    localizer => 'Lair::Localizer'
};

our $DELEGATES = {
    loc => 'localizer'
};

1;

__END__

