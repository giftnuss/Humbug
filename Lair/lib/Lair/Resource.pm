  package Lair::Resource;
# ***********************

use Badger;

use Badger::Class
    version => '0.01',
    base => 'Lair::Base',
    mixin => 'Lair::Mixin::Build',
    accessors => [
	'regex',    # a regex matching a path
        'vars',     # the named subpattern matched in the path
        'matches'   # the list of matches
    ],
    mutators => [
        'action',   # a code ref usual set by negotiator
        'get',
        'post',
        'delete',
        'put',
        'any',
        'returns',   # mime type
        'controller' # the controller - set after dispatch from outside
    ];

use Memoize ();
Memoize::memoize('_throw_405');

sub _throw_405 {
    return sub {
        shift->context->throw(405);
    }
}

sub _default_regex { qr|\Z\A| }

sub _default_get { &_throw_405 }

sub _default_post { &_throw_405 }

sub _default_put { &_throw_405 }

sub _default_delete { &_throw_405 }

sub _default_any { undef }

sub _default_returns { 'text/html' }

sub _reset {
    my ($self) = @_;
    $self->{'action'} = undef;
    $self->{'vars'} = undef;
    $self->{'matches'} = undef;
}

sub match {
    my ($self,$path) = @_;
    $self->_reset;
    my $result = $path =~ $self->regex;
    if($result) {
        $self->{'vars'} = {%+};
        $self->{'matches'} =
            [map { substr($path, $-[$_], $+[$_] - $-[$_]) } (0..$#-)];
    }
    return $result;
}

1;

__END__

