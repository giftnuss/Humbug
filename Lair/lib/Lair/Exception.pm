  package Lair::Exception; # HTTP
# ************************
use Lair::Ground;
use Lair::Response::Codes;

use Badger::Class
    version => '0.01',
    base => 'Badger::Exception',
    mixin => [
        'Lair::Mixin::Build'
    ],
    accessors => [
        'code',
        'description',
        'location',
        'name',
        'use_layout'
    ];

sub _default_01_code { 500 }

sub _default_use_layout { 1 }

sub _default_10_name
{
  $Leyland::CODES->{$_[0]->code}->[0] || 'Internal Server Error';
}

sub _default_11_description
{ 
  $Leyland::CODES->{$_[0]->code}->[0] || 'Generic HTTP exception';
}

sub _default_type { 'http' }

1;

__END__

