use strict;
use warnings;
use Plack::Test;
use Plack::Util;
use Test::More;
 
my $app = Plack::Util::load_psgi 'example/helloworld.psgi';

test_psgi
    app => $app,
    client => sub {
        my $cb = shift;
        my $req = HTTP::Request->new(
            GET => 'http://localhost/hello/Badger', [
                'User-Agent' => 'Badger/0.8/Honey',
        ]);
        my $res = $cb->($req);
        is $res->code, 200,'response code';
        like $res->content, qr/Hello Badger!/,'response body';
    };
 
done_testing;

