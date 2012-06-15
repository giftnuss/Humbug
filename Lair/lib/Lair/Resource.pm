  package Lair::Resource;
# ***********************
use Lair::Ground;

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
        'code',      # HTTP response code
        'returns',   # mime type
        'context',   # mostly it is the current request
        'controller' # the controller - set after dispatch from outside
    ];

use Memoize ();
Memoize::memoize('_throw_405');

sub _throw_405 {
    return sub {
        shift->context->error(405);
    }
}

sub _default_code { 200 }

sub _default_context { undef }

sub _default_controller { undef }

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

sub if_matched { }

sub error_msg
{
    shift;
    die("@_");
}

1;

__END__

=head1 NAME

Lair::Resource

=head1 SYNOPSIS

    my $resource = Lair::Resource->new(
        regex => qr|^/user/(<?name>\w+)$|,
        get => sub { ... },
        post => sub { ... });

=head1 DESCRIPTION

=head2 Accessors

=over 4

=item C<regex>

=item C<vars>

=item C<matches>

=back

=head2 HTTP actions

=over 4

=item C<get>

=item C<post>

=item C<delete>

=item C<put>

=item C<any>

=back

=head2 Mutators

=over 4

=item C<action> - a code ref usual set by negotiator. commonly one of
http method subroutins is used.

=item C<code> - the HTTP response code

=item C<returns> - the MIME type

=item C<context> - mostly the current request is used as value

=item C<controller> - it is set from outside as a result of the dispatch process

=back

=head2 Methods

=over 4

=item match

This method is called from a dispatcher with a chunk
of a path. This method checks if the regex bound to the
resource is matching the path string.

=back

=head2 Triggers

=over 4

=item "if_matched"

=back


