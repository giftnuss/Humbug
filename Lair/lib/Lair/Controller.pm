  package Lair::Controller;
# *************************

use Badger;

use Lair::Resource;

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
	'resources',
        'resource_class'
    ],
    utils => ['params'];

sub _default_prefix { '/' }

sub _default_resources { [] }

sub _default_resource_class { 'Lair::Resource' }

sub add_resource {
    my $self = shift;
    push @{$self->resources}, @_;
}

sub create_resource {
    my $self = shift;
    my $regex = shift;
    my $params = params(@_);
    $params->{'regex'} = $regex;
    $self->add_resource( $self->resource_class->new($params) );
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


