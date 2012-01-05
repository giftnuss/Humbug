  package Lair::Hub;
# ******************
use Badger;

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

