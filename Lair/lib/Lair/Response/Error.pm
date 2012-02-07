  package Lair::Response::Error;
# ******************************
use Lair::Ground;

use HTTP::Status ();

use Badger::Class
    version => '0.01',
    base => 'Lair::Resource';

{
    my $action = sub {
        my ($self,$response) = @_;
        return HTTP::Status::status_message($self->code);
    };

    sub _default_action { $action }

    sub _default_get { $action }

    sub _default_post { $action }

    sub _default_put { $action }

    sub _default_delete { $action }
}

sub _default_returns { 'text/plain' }

1;
