#!/usr/bin/perl
#  WebPage テスト Hello, World!

require "./WebPage.pm";

my $cgi = WebPage->new('templates/hello_world.html');
$cgi->setPlaceHolder("hello", "Hello,World!");
$cgi->echo();
