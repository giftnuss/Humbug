
use Test::More tests => 9;

BEGIN {
    use_ok('Lair::Controller');
    use_ok('Lair::Resource');
}

my $controller = Lair::Controller->new();

is_deeply($controller->resources,[],'start with empty resources');
is($controller->prefix,'/','root / is the default prefix');

my $dummy = Lair::Resource->new;
$controller->add_resource($dummy,$dummy);
is_deeply($controller->resources->[0],$dummy,'first resource');
is_deeply($controller->resources->[1],$dummy,'second resource');

$controller = Lair::Controller->new(prefix => '/recipe');
is($controller->prefix,'/recipe','prefix set during construction');
my $resource = $controller->create_resource(
        qr|^/ingredient/(?<name>[\w-]+)$|,
        get => sub { ... },
        returns => 'application/json'
);

isa_ok($resource,'Lair::Resource','default resource class is Lair::Resource');

my $controller2 = Lair::Controller->new(prefix => 'hello');
is($controller2->prefix,'/hello','/ is prepend when missing');