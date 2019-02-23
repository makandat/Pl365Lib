#!/usr/bin/perl
#  redirect
use strict;
use warnings;
require "./WebPage.pm";

our $cgi = WebPage->new('templates/redirect.html');

if ($cgi->isPostback('url')) {
  my $url = $cgi->getParam('url');
  WebPage::redirect($url);
}
else {
  $cgi->echo();
}
