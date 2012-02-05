  package Lair::Response::Redirect;
# *********************************

use Lair::Ground;

use Badger::Class
    version => '0.01',
    base => 'Lair::Resource',
    mutators => [
        'location'
    ];

sub _default_location { undef }
1;

__END__

