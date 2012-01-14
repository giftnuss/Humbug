  package Lair::Resource;
# ***********************

use Badger;

use Badger::Class
    version => '0.01',
    base => 'Lair::Base',
    mixin => 'Lair::Mixin::Build',
    accessors => [
        'action',   # a subroutine
        'context',  # the current context - set from outside
	'regex',    # an egex matchin a path
        'vars',     # the named subpattern matched in the path
        'matches'   # the list of matches
    ];

sub _default_regex { qr|\Z\A| }

sub _reset {
    my ($self) = @_;
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

