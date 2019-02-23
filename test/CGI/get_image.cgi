#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
require "./WebPage.pm";

use constant TEMPLATE => "./templates";

our $cgi = WebPage->new(TEMPLATE . "/get_image.html");
$cgi->add_header('Cache-Control: no-cache');
$cgi->echo();
