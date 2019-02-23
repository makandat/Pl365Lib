#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
require "./WebPage.pm";
use constant TEMPLATE => "./templates";

our $cgi = WebPage->new(TEMPLATE . "/cookie.html");
if ($cgi->isCookie('count')) {
  my $c = $cgi->getCookie('count');
  $c += 1;
  $cgi->setCookie('count', $c);
  $cgi->setPlaceHolder('count', $c);
}
else {
  $cgi->setCookie('count', '0');
  $cgi->setPlaceHolder('count', '0');
}
$cgi->echo();
