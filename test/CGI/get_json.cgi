#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
require "./WebPage.pm";

use constant TEMPLATE => "./templates";

our $cgi = WebPage->new(TEMPLATE . "/get_json.html");
$cgi->echo();
