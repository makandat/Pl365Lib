#!/usr/bin/perl
#  fahren.cgi
require "./WebPage.pm";

our $cgi = WebPage->new;
our $t = $cgi->getParam('text1');
our $cf = $cgi->getParam('temp');
our $v;

if ($cf eq 'F') {
  # F to C
  $v = 5.0 * ($t - 32.0) / 9.0;
}
else {
  # C to F
  $v = 9.0 * $t / 5.0 + 32.0;
}

WebPage::sendText($v);
