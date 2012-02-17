package Lair::Controller::Favicon;

use Lair::Ground;
use Lair::Resource;

use Badger::Class
    version => '0.01',
    base => 'Lair::Controller',
    mutators => [
        'favicon'
    ];

sub _default_prefix { '/favicon.ico' }

sub _default_resources
{[
  Lair::Resource->new(regex => qr||,
    get => sub { shift->controller->favicon },
    returns => 'image/x-icon')
]}

sub _default_favicon {
  return Badger::Codec::Base64->decode(
'AAABAAEAEBAAAAEACAB8AgAAFgAAAIlQTkcNChoKAAAADUlIRFIAAAAQAAAAEAgGAAAAH/P/YQAA
AkNJREFUOI1d0U1vW0UUxvHfnTt+i+vYad5aWqDQBFiwZMEKAR+Jb9RPwYYlCzYgkKpCWxEgUZyQ
OolTv8TX19fDwq6qcqSjmedIz6M5/8l++fp+Ch8OZAelZZuiopwxnzA6Y/wvtRq97Vxvt6e1N1fb
GgkbqBGXVyO33VJ6xcYmMTE+ZfqK4ozihOYDpkUlxEuzBZ0ltRmtfbIndw9SmZ2yeau+xe4hYUQ+
ZdFndko5IQt0vw2m5VL9PTbukW0Qb3pdreup0J+ZniT9Kxol7RIj5recwJLsh6W9j8jnFDPqHWLj
9KleVuiV9B5xec3rBT+PKFdrquO1ld4acPEXMcMG4aoohBl7S7bGtK6ZjOhh09uQBvbQHfOoyZ1E
NSFOcYshBgUvcY4FctxZ64v1fTOtAO42qAfirobQqBxXC/2bVdAE2+2Wk8mtHH0co4lf8Ridgi8O
78qefPx5Oj566hJXKPAM7yPD92sGd9avKnGwnhWIRzdXfsfNevDj2rhA2GbzkogBwuozDNfnHL7r
5Okrkv/1w30pZm91K0rffCl1oxRr0k5bapPiOFV6HfZHK5jdHaqM8YiHH2zLGoQ8WsxrzsczzXtb
Jtfbuns/2TkjZotMQFPSapLX+bNPO+fvfy6FwOEn3Ax3XFzsi2GmnX4zOl+tFjspmqfk1EI1I/aB
Bx2OhqQlz/9g30DTQC0nVlRroHGY5Z4VM5+9gYIXeDH0TtXWfXA/CvNKJhGI0zQ3t0p8U5/i+bt+
DTzukI0Xwsor4D9pfvnjN1UBAgAAAABJRU5ErkJggg==')
}

1;

__END__

=head NAME

Lair::Controller::Favicon - a default favicon controller

