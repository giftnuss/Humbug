  package Lair::Controller;
# *************************

use Badger;

use Badger::Class
    version => '0.01',
    base => 'Lair::Base',
    mixin => [
        'Lair::Mixin::Build'
    ],
    mutators => [
        'prefix'
    ],
    accessors => [
	'resources'
    ],
    utils => ['params'];

sub _default_prefix { '/' }

sub _default_resources { [] }

sub add_resource {
    my $self = shift;
    push @{$self->resources}, @_;
}

sub create_resource {
    my $self = shift;
    my $regex = shift;
    my $params = params(@_);

}

1;

__END__

=head1 NAME

Lair::Controller - bundles of one or more rsources

=head1 SYNOPSIS

    my $controller = Lair::Controller->new(prefix => '/recipe');
    $controller->create_resource(
        qr|^/ingredient/(?<name>[\w-]+)$|,
        get => sub { ... },
        returns => 'application/json'
    );

=head1 DESCRIPTION


