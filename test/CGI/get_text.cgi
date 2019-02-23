#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
require "./WebPage.pm";
require "./Common.pm";
require "./FileSystem.pm";
require "./Text.pm";

use constant TEMPLATE => "./templates";

our $cgi = WebPage->new(TEMPLATE . "/get_text.html");
$cgi->echo();
