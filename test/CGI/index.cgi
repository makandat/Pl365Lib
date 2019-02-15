#!/usr/bin/perl
#  WebPage テストのトップページ

require "./WebPage.pm";

my $cgi = WebPage->new('templates/index.html');
$cgi->echo();
