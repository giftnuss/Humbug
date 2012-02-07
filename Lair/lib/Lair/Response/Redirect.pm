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

{
  my $action = sub {
        my ($self,$response) = @_;
        $response->redirect($self->location);
        return ();
  };

  sub _default_action { $action }

  sub _default_get { $action }

  sub _default_post { $action }

  sub _default_delete { $action }

  sub _default_put { $action }
}

1;

__END__

