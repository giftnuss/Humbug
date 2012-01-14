
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name => 'Lair',
    license => 'perl',
    dist_abstract => 'a small web framework',
    dist_author => 'Sebastian Knapp <rock@ccls-online.de>',
    dist_version => '0.01001',
    requires => {
        'perl' => '5.010001',
        'Badger' => '0.08',
        'Package::Subroutine' => '0.20',
        'Plack' => 0
    },
    build_requires => {
        'Test::More' => 0
    },
    add_to_cleanup      => [ 'Lair-*' ],
    create_makefile_pl  => 'traditional',
    meta_add => {
        resources => {
            repository => 'git://github.com/giftnuss/Humbug',
        }
    }
);

$builder->create_build_script();
