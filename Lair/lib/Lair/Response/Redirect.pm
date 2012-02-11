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

sub _default_regex { qr|^/.*$| }

{
  my $action = sub {
        my ($self,$response) = @_;
        my $location = $self->location;
        if(substr($location,0,1) eq '/') {
            my $uri = $self->context->uri;
            my $base = $uri->canonical;
            if(my $pos = index($base,'/',length($uri->scheme)+3)) {
                $base = substr($base,0,$pos);
	    }
            $location = $base . $location;
        }
        $response->redirect($location);
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

