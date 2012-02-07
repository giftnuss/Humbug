
use strict;
use warnings;

use Test::More tests => 4;
use Try::Tiny;

BEGIN {
  use_ok('Lair');
  use_ok('Lair::Context');
};


my $env = {
    'psgi.url_scheme' => 'http',
    HTTP_HOST => 'example.com'
};

my $app = Lair->new();
my $responder = $app->respond;
my $context = Lair::Context->new($env);

{
  my $error = try { $context->error(500) } catch { return $_ };
  is_deeply
      $responder->exception($error)->finalize,
      [ 500, 
          [
               'Content-Type',
               'text/plain',
               'X-Framework',
               'Lair v0.01'
          ],['Internal Server Error'] ],'error response';
}

{
  my $redirect = try { $context->redirect('http://perl.org') } catch { return $_ };
  is_deeply
      $responder->exception($redirect)->finalize,
      [ 302,
          [
             'Location',
             'http://perl.org',
             'X-Framework',
             'Lair v0.01'
          ],[] ],'simple redirect';

}
