#!/usr/bin/perl
use strict;
use warnings;
require "./WebPage.pm";


our $cgi = WebPage->new;
our $regex = $cgi->getParam('regex');
our $text = $cgi->getParam('text');

my $a = "false";
if ($text =~ /$regex/) {
  $a = "true";
}

WebPage::sendJson('{"result":'.$a.'}');
