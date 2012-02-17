  package Lair::Controller;
# *************************
use Lair::Ground;
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

sub check {
    my $self = shift;
    if(substr($self->prefix,0,1) ne '/') {
        $self->{'prefix'} = '/' . $self->{'prefix'};
    }
}

sub add_resource {
    my $self = shift;
    push @{$self->resources}, @_;
    return $self;
}

sub create_resource {
    my $self = shift;
    my $regex = shift;
    my $params = params(@_);
    $params->{'regex'} = $regex;
    my $resource =  $self->resource_class->new($params);
    $self->add_resource($resource );
    return $resource;
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

=head2 Methods

=over 4

=item C<add_resource>

This method is for adding resource objects. Returns the controller instance.

=item C<create_resource>

=back




