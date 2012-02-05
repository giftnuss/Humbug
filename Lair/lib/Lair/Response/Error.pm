  package Lair::Response::Error;
# ******************************
use Lair::Ground;

use HTTP::Status ();

use Badger::Class
    version => '0.01',
    base => 'Lair::Resource';

sub _default_action {
    return sub {
        my ($self,$response) = @_;
        return HTTP::Status::status_message($self->code);
    }
}

1;
