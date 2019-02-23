#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
require "./WebPage.pm";
require "./Common.pm";
require "./FileSystem.pm";
require "./Text.pm";

use constant TEMPLATE => "./templates";

our $cgi = WebPage->new(TEMPLATE . "/upload.html");

if ($cgi->isPostback('file1')) {
  $cgi->saveFile('file1');
  my $filename = $cgi->{params}->{file1}->[0];
  $cgi->setPlaceHolder('message', 'Saved to /var/www/data/'.$filename);
}
else {
  $cgi->setPlaceHolder('message', '');
}

$cgi->echo();
