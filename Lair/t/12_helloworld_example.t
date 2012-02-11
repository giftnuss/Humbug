use strict;
use warnings;
use Plack::Test;
use Plack::Util;
use Test::More;
 
{
  my $app = Plack::Util::load_psgi 'example/helloworld.psgi';

  my @controllers;
  Lair::Context->add_trigger('use_controllers',sub {@controllers = @{$_[1]}});

  test_psgi
    app => $app,
    client => sub {
        my $cb = shift;
        my $req = HTTP::Request->new(
            GET => 'http://localhost/hello/Badger', ['User-Agent' => 'Badger/0.8/Honey']);
        my $res = $cb->($req);
        is_deeply([map{$_->prefix}@controllers],['/hello','/'],'controllers');
        is $res->code, 200,'response code';
        like $res->content, qr/Hello Badger!/,'response body';

        $req = HTTP::Request->new(
            GET => 'http://localhost/', ['User-Agent' => 'Badger/0.8/Honey']);
        $res = $cb->($req);
        is_deeply([map{$_->prefix}@controllers],['/'],'controllers');
        is $res->code, 302,'response code';
        is $res->headers->header('Location'),'http://localhost/hello/','location header';

        $req = HTTP::Request->new(
            GET => 'http://localhost/favicon.ico', ['User-Agent' => 'Badger/0.8/Honey']);
        $res = $cb->($req);
        is_deeply([map{$_->prefix}@controllers],['/favicon.ico','/'],'controllers');
        is $res->code, 200,'response code';
        is $res->headers->header('Content-type'),'image/x-icon','content type';

    };
} 
done_testing;

