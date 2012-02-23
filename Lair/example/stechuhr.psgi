#!/usr/bin/perl

use lib './lib';
use Lair::Ground;

package Stechuhr;
use Badger::Class
    base => 'Lair::Resource';

my $site = <<__HTML__;
<!doctype html>
<html>
<head>
<style>
  h1 { margin:0 auto; height:40px; }
  img { max-height:20em; max-width:20em; margin:4em; }
</style>
<script>

{
   var seconds = -1;
   function fmt(num) {
       if(num < 10) return "0".concat(num);
       return num;
   }
   function tick () {
       var ele = document.getElementById('showtime');
       seconds++;
       var help = new Date(seconds * 1000);
       var data = new Array();
       if(help.getUTCHours()) data.push(help.getUTCHours());
       var minutes = help.getMinutes();
       if(minutes) data.push(fmt(minutes));
       var sec = help.getSeconds();
       if(sec || true) data.push(fmt(sec));
       ele.firstChild.nodeValue = "Duration: " + data.join(':');
   }
   function startwatch () {
       setInterval(tick,1000);
       tick();
   }
}
window.onload=startwatch; 
</script>
</head>
<body>
<h1 id="showtime"> </h1>
<div id="status"></div>
<a href="/pause">
  <img src="http://www.gfs-umweltausschuss.de/wp-content/uploads/Unbenannt-4.png">
</a>
<a href="/redmine">
  <img src="http://www.redmine.org/attachments/3462/redmine_fluid_icon.png">
</a>
<a href="/email">
  <img src="http://www.geeks2null.de/wp-content/uploads/2009/03/thunderbird-80x80.jpg">
</a>
<a href="/coding/php">
  <img src="http://macin.files.wordpress.com/2010/07/komodo-edit-6-0-0b2-icon.png">
</a>
<a href="/kommunikation">
  <img src="http://www.outdoor4business.de/assets/images/kommunikation.jpg">
</a>
<a href="/groupware">
  <img src="http://www.abclinuxu.cz/images/clanky/tuharsky/egroupware-schema_s.png">
</a>
</body>
</html>
__HTML__

sub _default_get {
    sub{ 	
	my ($self,$response) = @_;
	return $site;
    }
}

package main;
use Lair;
use Lair::Controller;
use Lair::Controller::Favicon;

use Plack::Builder;

my $app = Lair->new('name' => 'a no fun app!');
my $controller = Lair::Controller->new();
my $page = Stechuhr->new(
    regex => qr|^/(?<name>[\w\s]*)/?(?<desc>.*)$|,
);

$app->add_controller($controller->add_resource($page),Lair::Controller::Favicon->new);

builder { $app->handler };

